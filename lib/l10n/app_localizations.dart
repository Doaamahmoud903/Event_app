import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get splashTitle;

  /// No description provided for @splashDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get splashDescription;

  /// No description provided for @splashBtn.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start'**
  String get splashBtn;

  /// No description provided for @splashP2Title.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get splashP2Title;

  /// No description provided for @splashP3Title.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get splashP3Title;

  /// No description provided for @splashP4Title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get splashP4Title;

  /// No description provided for @splashP1Body.
  ///
  /// In en, this message translates to:
  /// **'We Are Very Excited To Have You In Our Community'**
  String get splashP1Body;

  /// No description provided for @splashP2Body.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get splashP2Body;

  /// No description provided for @splashP3Body.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get splashP3Body;

  /// No description provided for @splashP4Body.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get splashP4Body;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'what do you search for?'**
  String get searchHint;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Cairo , Egypt'**
  String get address;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @work_shop.
  ///
  /// In en, this message translates to:
  /// **'Work Shop'**
  String get work_shop;

  /// No description provided for @book_club.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get book_club;

  /// No description provided for @exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get exhibition;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get eating;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later.'**
  String get error;

  /// No description provided for @login_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back To Electro'**
  String get login_welcome;

  /// No description provided for @sign_msg.
  ///
  /// In en, this message translates to:
  /// **'Please sign in with your mail'**
  String get sign_msg;

  /// No description provided for @forget_password_ques.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password_ques;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @not_have_account_ques.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account ?'**
  String get not_have_account_ques;

  /// No description provided for @have_account_ques.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get have_account_ques;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get re_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @find_your_account.
  ///
  /// In en, this message translates to:
  /// **'Find Your Account'**
  String get find_your_account;

  /// No description provided for @register_success.
  ///
  /// In en, this message translates to:
  /// **'Account successfully created 🎉'**
  String get register_success;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @search_for_event.
  ///
  /// In en, this message translates to:
  /// **'Search For Event'**
  String get search_for_event;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_required;

  /// No description provided for @name_invalid.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get name_invalid;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get email_invalid;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_required;

  /// No description provided for @password_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password_length;

  /// No description provided for @password_complexity.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase & numbers'**
  String get password_complexity;

  /// No description provided for @confirm_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirm_password_required;

  /// No description provided for @passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwords_not_match;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get add_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @reading_book_club.
  ///
  /// In en, this message translates to:
  /// **'Reading Book Club'**
  String get reading_book_club;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get event_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get event_time;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @event_description.
  ///
  /// In en, this message translates to:
  /// **'Event description'**
  String get event_description;

  /// No description provided for @choose_event_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get choose_event_location;

  /// No description provided for @edit_event.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event;

  /// No description provided for @update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update_event;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get select_date;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get select_time;

  /// No description provided for @description_required.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get description_required;

  /// No description provided for @description_invalid.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get description_invalid;

  /// No description provided for @event_title_required.
  ///
  /// In en, this message translates to:
  /// **'Event title is required'**
  String get event_title_required;

  /// No description provided for @event_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event added successfully'**
  String get event_added_successfully;

  /// No description provided for @event_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event updated successfully'**
  String get event_updated_successfully;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @delete_event_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event deleted successfully'**
  String get delete_event_successfully;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete_event.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get delete_event;

  /// No description provided for @delete_event_ques.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this event?'**
  String get delete_event_ques;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @location_error.
  ///
  /// In en, this message translates to:
  /// **'Error getting location name'**
  String get location_error;

  /// No description provided for @no_loc.
  ///
  /// In en, this message translates to:
  /// **'Location not found'**
  String get no_loc;

  /// No description provided for @no_loc_msg.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find your location. Try again later.'**
  String get no_loc_msg;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
