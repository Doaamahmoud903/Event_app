import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/language_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/ui/auth/forget_password/forget_password_view.dart';
import 'package:event_app/ui/auth/login/login_view.dart';
import 'package:event_app/ui/auth/register/register_view.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/ui/onboarding/splash_screen.dart';
import 'package:event_app/utils/app_themes.dart';
import 'package:event_app/ui/event/add_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  //Theme
  final savedTheme = prefs.getString('themeMode');
  final themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  //Language
  final savedLang = prefs.getString('language');
  final lang = savedLang ?? 'en';

  //await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(themeMode)),
        ChangeNotifierProvider(create: (context) => LanguageProvider(lang)),
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Event App',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        AddEvent.routeName: (context) => AddEvent(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentLocal),
    );
  }
}
