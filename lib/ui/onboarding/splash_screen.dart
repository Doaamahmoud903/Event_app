import 'package:event_app/ui/onboarding/splash_pages.dart';
import 'package:event_app/ui/onboarding/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_app/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startedSplash = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 50,
          centerTitle: true,
          title: SizedBox(
            height: 50,
            child: Image.asset(AppAssets.mainLogo),
          ),
        ),
        body: !_startedSplash
            ? WelcomeScreen(onStart: () {
                setState(() {
                  _startedSplash = true;
                });
              })
            : SplashPages());
  }
}
