import 'package:event_app/firebase_utils.dart';
import 'package:event_app/modals/event_model.dart';
import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/event/location_picker_screen.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/widgets/choose_box.dart';
import 'package:event_app/widgets/custom_button.dart';
import 'package:event_app/widgets/custom_text_form_field.dart';
import 'package:event_app/ui/event/event_tab_item.dart';
import 'package:event_app/widgets/custom_toast.dart';
import 'package:event_app/widgets/cutom_content_row.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/event_data.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_styles.dart';

int selectedIndex = 1;

class AddEvent extends StatefulWidget {
  static const String routeName = "AddEvent";

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String formatedDate = "";
  String formatedTime = "";
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String selectedImageLight = '';
  String selectedImageDark = '';
  String selectEventName = '';
  List<Event> eventList = [];
  LatLng? selectedLatLng;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    TextStyle hintTheme = themeProvider.currentTheme == ThemeMode.light
        ? AppStyles.semibold16lightGray
        : AppStyles.bold16white;
    var eventProvider = Provider.of<EventProvider>(context);
    List<IconData> filteredEventIcons = eventIcons.sublist(2);
    List<String> filteredEventImgLight = eventImgLight;
    List<String> filteredEventImgDark = eventImgDark;
    List<String> getFilteredEventNameList(BuildContext context) {
      return getEventNameList(context).sublist(1);
    }

    List<String> eventNameList = getFilteredEventNameList(context);

    selectedImageLight = filteredEventImgLight[selectedIndex];
    selectedImageDark = filteredEventImgDark[selectedIndex];
    selectEventName = getFilteredEventNameList(context)[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.add_event,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(themeProvider.currentTheme == ThemeMode.light
                    ? selectedImageLight!
                    : selectedImageDark!),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedImageLight =
                              filteredEventImgLight[selectedIndex];
                          selectedImageDark =
                              filteredEventImgDark[selectedIndex];
                          selectEventName =
                              getFilteredEventNameList(context)[selectedIndex];
                        });
                      },
                      child: EventTabItem(
                        containerSelected: AppColors.primaryColor,
                        containerUnSelected: AppColors.whiteColor,
                        borderSelected: AppColors.transparentColor,
                        borderUnSelected: AppColors.primaryColor,
                        lightSelected: AppColors.whiteColor,
                        darkSelected: AppColors.darkBlueColor,
                        baseUnselected: AppColors.primaryColor,
                        iconData: filteredEventIcons[selectedIndex],
                        eventName: eventNameList[index],
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * 0.02);
                  },
                  itemCount: eventIcons.length - 1,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Text(AppLocalizations.of(context)!.title),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              //Title TextField
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                        child: CustomTextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .event_title_required;
                              }
                              return null;
                            },
                            controller: titleController,
                            hint: AppLocalizations.of(context)!.event_title,
                            iconPath: AppAssets.penIcon,
                            iconColor:
                                themeProvider.currentTheme == ThemeMode.light
                                    ? AppColors.lightGrayColor
                                    : AppColors.whiteColor,
                            hintStyle: hintTheme,
                            enableBorderColor: AppColors.lightGrayColor,
                            focusBorderColor: AppColors.primaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Text(AppLocalizations.of(context)!.description),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      //Description TextField
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: CustomTextFormField(
                            validator: (text) {
                              if (text!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .description_required;
                              }
                              return null;
                            },
                            lines: 3,
                            length: 200,
                            controller: descController,
                            hint:
                                AppLocalizations.of(context)!.event_description,
                            iconColor:
                                themeProvider.currentTheme == ThemeMode.light
                                    ? AppColors.lightGrayColor
                                    : AppColors.whiteColor,
                            hintStyle: hintTheme,
                            enableBorderColor: AppColors.lightGrayColor,
                            focusBorderColor: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      // Date Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: CustomContentRow(
                          title: AppLocalizations.of(context)!.event_date,
                          TimeOrDate: formatedDate.isEmpty
                              ? AppLocalizations.of(context)!.select_date
                              : formatedDate,
                          iconPath: AppAssets.clock,
                          titleColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          TimeOrDateColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.blueColor
                                  : AppColors.primaryColor,
                          selectTimeOrDate: () {
                            chooseDate();
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      // Time Row
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: CustomContentRow(
                          title: AppLocalizations.of(context)!.event_time,
                          TimeOrDate: formatedTime.isEmpty
                              ? AppLocalizations.of(context)!.select_time
                              : formatedTime,
                          iconPath: AppAssets.calender,
                          titleColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          TimeOrDateColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.blueColor
                                  : AppColors.primaryColor,
                          selectTimeOrDate: () {
                            chooseTime();
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Text(
                          AppLocalizations.of(context)!.location,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Center(
                        child: ChooseBox(
                          title: AppLocalizations.of(context)!.location,
                          suffixIconColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.lightGrayColor
                                  : AppColors.whiteColor,
                          containerColor: AppColors.transparentColor,
                          titleColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          prefixIconPath: AppAssets.locationIcon,
                          prefixIconColor: AppColors.whiteColor,
                          suffixIconPath: AppAssets.arrowDownIcon,
                          borderColor:
                              themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.lightGrayColor
                                  : AppColors.whiteColor,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LocationPickerScreen()),
                            );
                            if (result != null && result is LatLng) {
                              setState(() {
                                selectedLatLng = result;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: CustomButton(
                            text: AppLocalizations.of(context)!.add_event,
                            textStyle: AppStyles.bold20white,
                            backgroundColor:
                                themeProvider.currentTheme == ThemeMode.light
                                    ? AppColors.blueColor
                                    : AppColors.primaryColor,
                            onPressed: () {
                              addEvent(eventProvider);
                            }),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formatedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectedTime = chooseTime;
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      formatedTime = DateFormat('hh:mm a').format(selectedDateTime);
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void addEvent(EventProvider eventProvider) async {
    if (formKey.currentState!.validate()) {
      Event event = Event(
        title: titleController.text,
        description: descController.text,
        eventName: selectEventName,
        dateTime: selectedDate!,
        time: formatedTime,
        imageLight: selectedImageLight,
        imageDark: selectedImageDark,
        location: selectedLatLng,
      );
      final userProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      FirebaseUtils.addEventToFirestore(event, userProvider.currentUser!.id)
          .then((value) {
        CustomToast.showToast(
          msg: AppLocalizations.of(context)!.event_added_successfully,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.whiteColor,
          fontSize: 16.0,
        );
        eventProvider.getAllEvents(userProvider.currentUser!.id);
        Navigator.pop(context);
      }).timeout(const Duration(seconds: 3), onTimeout: () {
        CustomToast.showToast(
          msg: AppLocalizations.of(context)!.event_added_successfully,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.greenColor,
          textColor: AppColors.whiteColor,
          fontSize: 16.0,
        );
        eventProvider.getAllEvents(userProvider.currentUser!.id);
        Navigator.pop(context);
      }).catchError((error) {
        print(error.toString());
        CustomToast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.errorColor,
          textColor: AppColors.whiteColor,
          fontSize: 16.0,
        );
      });
    }
  }
}
