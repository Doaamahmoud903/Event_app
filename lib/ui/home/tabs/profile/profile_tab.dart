import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/auth/login/login_view.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/language_provider.dart';
import '../../../../widgets/language_bottom_sheet.dart';
import '../../../../widgets/theme_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var userProvider = Provider.of<UserDataProvider>(context);

    final colorCondition = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.blueColor
        : AppColors.primaryColor;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(64)),
            child: Container(
              color: colorCondition,
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              child: Row(
                children: [
                  Image.asset(AppAssets.profileLogoTab,
                      width: 100, height: 100),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.currentUser!.name,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.currentUser!.email,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle(
                context, AppLocalizations.of(context)!.language, height),
            selectionBox(
              context,
              title:
                  languageProvider.currentLocal == "en" ? "English" : "العربيه",
              color: colorCondition,
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) => const LanguageBottomSheet(),
                backgroundColor: themeProvider.currentTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.darkBlueColor,
              ),
            ),
            sectionTitle(context, AppLocalizations.of(context)!.theme, height),
            selectionBox(
              context,
              title: themeProvider.currentTheme == ThemeMode.light
                  ? AppLocalizations.of(context)!.light
                  : AppLocalizations.of(context)!.dark,
              color: colorCondition,
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (_) => const ThemeBottomSheet(),
                backgroundColor: themeProvider.currentTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.darkBlueColor,
              ),
            ),
            const Spacer(),
            logoutBox(context, height),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String text, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Text(text, style: Theme.of(context).textTheme.headlineLarge),
    );
  }

  Widget selectionBox(BuildContext context,
      {required String title,
      required Color color,
      required VoidCallback onTap}) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Icon(Icons.arrow_drop_down, color: color, size: 30),
          ],
        ),
      ),
    );
  }

  Widget logoutBox(BuildContext context, double height) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.02),
      decoration: BoxDecoration(
        color: AppColors.redColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.redColor),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Logout logic
          //FirebaseAuth.instance.signOut();
          Provider.of<UserDataProvider>(context, listen: false)
              .setCurrentUser(null);
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        },
        child: Row(
          children: [
            ImageIcon(
              AssetImage(AppAssets.logoutIcon),
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.logout,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
