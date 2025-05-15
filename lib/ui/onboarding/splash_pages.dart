import 'package:event_app/firebase_utils.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/auth/login/login_view.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});
  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  _SplashPagesState();
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> splashPages = [
      {
        "img": AppAssets.splashIcon2,
        "imgDark": AppAssets.splashIcon2Dark,
        "title": AppLocalizations.of(context)!.splashTitle,
        "body": AppLocalizations.of(context)!.splashP1Body,
      },
      {
        "img": AppAssets.splashIcon3,
        "imgDark": AppAssets.splashIcon3,
        "title": AppLocalizations.of(context)!.splashP2Title,
        "body": AppLocalizations.of(context)!.splashP2Body,
      },
      {
        "img": AppAssets.splashIcon4,
        "imgDark": AppAssets.splashIcon4Dark,
        "title": AppLocalizations.of(context)!.splashP3Title,
        "body": AppLocalizations.of(context)!.splashP3Body,
      },
      {
        "img": AppAssets.splashIcon5,
        "imgDark": AppAssets.splashIcon5Dark,
        "title": AppLocalizations.of(context)!.splashP4Title,
        "body": AppLocalizations.of(context)!.splashP4Body,
      },
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: splashPages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final page = splashPages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      page[themeProvider.currentTheme == ThemeMode.light
                          ? "img"
                          : "imgDark"]!,
                      width: width * 0.9,
                      height: height * 0.4,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Text(
                      page["title"] ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                    ),
                    child: Text(
                      page["body"] ?? '',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentIndex > 0)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      languageProvider.currentLocal == "en"
                          ? AppAssets.backIcon
                          : AppAssets.nextIcon,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.fill,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              Spacer(),
              Row(
                children: List.generate(
                  splashPages.length,
                  (index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: _currentIndex == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? (themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor)
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: Image.asset(
                    languageProvider.currentLocal == "en"
                        ? AppAssets.nextIcon
                        : AppAssets.backIcon,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.fill,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () => _goToNext(splashPages),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    if (uid != null) {
      final userData = await FirebaseUtils.readUserFromDb(uid);
      if (userData != null) {
        Provider.of<UserDataProvider>(context, listen: false)
            .setCurrentUser(userData);
        print("There is a User");
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        print("Null User");
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    } else {
      print("Null User");
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    }
  }

  void _goToNext(List<Map<String, String>> splashPages) {
    if (_currentIndex < splashPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      checkLogin();
    }
  }
}
