import 'package:event_app/firebase_utils.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modals/event_model.dart';
import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final GlobalKey<CustomLoadingItemState> loadingKey =
      GlobalKey<CustomLoadingItemState>();
  GoogleMapController? mapController;
  String? mapStyle;
  loc.Location location = loc.Location();
  LatLng? intialLatLong;

  Future<void> getCurrentLocation() async {
    // step 1  check if the user enable location service
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    // step 2 check permission state
    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    if (permissionGranted == loc.PermissionStatus.deniedForever) {
      return;
    }
    // step 3 get the current location
    var currentLocation = await location.getLocation();
    if (currentLocation == null) {
      return;
    }
    // step 4 update map camera position
    setState(() {
      intialLatLong =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  Future<void> loadMapStyle() async {
    String style =
        await rootBundle.loadString("assets/map_styles/map_style.json");
    setState(() {
      mapStyle = style;
    });
  }

  Future<String> getPlaceName(LatLng location) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemark.isNotEmpty) {
        Placemark place = placemark.first;
        print("Trrrrrrrrrrrrrry ${place.street}, ${place.locality}");
        return "${place.street}, ${place.locality}";
      }
    } catch (e) {
      print("Catcccccccccch error");
      print("${AppLocalizations.of(context)!.location_error}: $e");
    }
    print("Errrrrrrrrrror");
    return AppLocalizations.of(context)!.no_loc;
  }

  @override
  void initState() {
    super.initState();
    loadMapStyle();
    getCurrentLocation();
    var userProvider = Provider.of<UserDataProvider>(context, listen: false);
    Provider.of<EventProvider>(context, listen: false)
        .getAllEvents(userProvider.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return intialLatLong == null
        ? Center(
            child: CustomLoadingItem(
            key: loadingKey,
            initialVisible: true,
          ))
        : Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        intialLatLong!.latitude, intialLatLong!.longitude),
                    zoom: 10,
                  ),
                  mapType: MapType.normal,
                  markers: eventProvider.eventList
                      .where((e) => e.location != null)
                      .map((event) => Marker(
                            markerId: MarkerId(event.id),
                            position: event.location!,
                            infoWindow: InfoWindow(title: event.eventName),
                          ))
                      .toSet(),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: FloatingActionButton(
                    onPressed: () async {
                      var currentLocation = await location.getLocation();
                      if (mapController != null) {
                        mapController!
                            .animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(currentLocation.latitude!,
                                currentLocation.longitude!),
                            zoom: 14,
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: height * 0.03,
                  left: 0,
                  right: 0,
                  height: height * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventProvider.eventList.length,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final event = eventProvider.eventList[index];
                      return Container(
                        width: width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.015),
                        decoration: BoxDecoration(
                          color: themeProvider.currentTheme == ThemeMode.light
                              ? Colors.white
                              : AppColors.darkBlueColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryColor),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ],
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.4,
                              height: height * 0.15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(
                                      themeProvider.currentTheme ==
                                              ThemeMode.light
                                          ? event.imageLight!
                                          : event.imageDark!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(event.eventName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor)),
                                  SizedBox(height: height * 0.01),
                                  event.location != null
                                      ? Expanded(
                                          child: FutureBuilder<String>(
                                            future:
                                                getPlaceName(event.location!),
                                            builder: (context, snapshot) {
                                              print(
                                                  "Lat: ${event.location!.latitude}, Lng: ${event.location!.longitude}");

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Wrap(children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .loading,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: themeProvider
                                                                    .currentTheme ==
                                                                ThemeMode.light
                                                            ? AppColors
                                                                .darkBlueColor
                                                            : Colors.white),
                                                  )
                                                ]);
                                              } else if (snapshot.hasError) {
                                                return Wrap(children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .location_error,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: themeProvider
                                                                    .currentTheme ==
                                                                ThemeMode.light
                                                            ? AppColors
                                                                .darkBlueColor
                                                            : Colors.white),
                                                  ),
                                                ]);
                                              } else {
                                                return Wrap(
                                                  children: [
                                                    Text(
                                                      snapshot.data ??
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .no_loc,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: themeProvider
                                                                      .currentTheme ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .darkBlueColor
                                                              : Colors.white),
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      : Wrap(children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .no_loc_msg,
                                          ),
                                        ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
