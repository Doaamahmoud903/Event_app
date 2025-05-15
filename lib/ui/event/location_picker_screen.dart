import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});
  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng? selectedLocation;
  LatLng initialLocation = LatLng(30.0444, 31.2357);
  // Cairo as default
  final Location location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Get location
    locationData = await location.getLocation();
    setState(() {
      initialLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Pick Location',
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      )),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14.0,
        ),
        onTap: (LatLng latLng) {
          setState(() {
            selectedLocation = latLng;
          });
        },
        markers: selectedLocation == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: selectedLocation!,
                )
              },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedLocation != null) {
            Navigator.pop(context, selectedLocation);
          }
        },
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
