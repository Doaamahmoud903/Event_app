import 'package:event_app/ui/home/tabs/home/home_tab.dart';
import 'package:event_app/ui/home/tabs/love/love_tab.dart';
import 'package:event_app/ui/home/tabs/map/map_tab.dart';
import 'package:event_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:event_app/ui/event/add_event.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.transparentColor,
        ),
        child: BottomAppBar(
          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          color: themeProvider.currentTheme == ThemeMode.light
              ? AppColors.blueColor
              : AppColors.darkBlueColor,
          notchMargin: 4,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              buildBottomNavbarItems(
                iconName: AppAssets.homeIcon,
                selectedIconName: AppAssets.selectedHomeIcon,
                index: 0,
                label: AppLocalizations.of(context)!.home,
              ),
              buildBottomNavbarItems(
                iconName: AppAssets.mapIcon,
                selectedIconName: AppAssets.selectedMapIcon,
                index: 1,
                label: AppLocalizations.of(context)!.map,
              ),
              buildBottomNavbarItems(
                iconName: AppAssets.loveIcon,
                selectedIconName: AppAssets.selectedLoveIcon,
                index: 2,
                label: AppLocalizations.of(context)!.love,
              ),
              buildBottomNavbarItems(
                iconName: AppAssets.profileIcon,
                selectedIconName: AppAssets.selectedProfileIcon,
                index: 3,
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildBottomNavbarItems({
    required String selectedIconName,
    required int index,
    required String iconName,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(selectedIndex == index ? selectedIconName : iconName),
      ),
      label: label,
    );
  }
}
