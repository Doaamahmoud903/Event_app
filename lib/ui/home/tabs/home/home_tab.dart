import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:event_app/widgets/event_post_item.dart';
import 'package:event_app/ui/event/event_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../providers/language_provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:event_app/data/event_data.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserDataProvider>(context, listen: false);

    Provider.of<EventProvider>(context, listen: false)
        .getAllEvents(userProvider.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var eventProvider = Provider.of<EventProvider>(context);
    var userProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: AppStyles.semiBold14white,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24white,
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  AppAssets.sunIcon,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.01),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.whiteColor),
                  child: Center(
                    child: Text(
                        languageProvider.currentLocal == "en"
                            ? "EN"
                            : "العربيه",
                        style: TextStyle(
                            color: themeProvider.currentTheme == ThemeMode.light
                                ? AppColors.blueColor
                                : AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.14,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.02),
            decoration: BoxDecoration(
                color: themeProvider.currentTheme == ThemeMode.light
                    ? AppColors.blueColor
                    : AppColors.darkBlueColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AppAssets.mapIcon),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(AppLocalizations.of(context)!.location,
                        style: TextStyle(color: AppColors.whiteColor)),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DefaultTabController(
                  length: eventProvider.getEventNameList(context).length,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (index) {
                          eventProvider.changeIndex(
                              index, userProvider.currentUser!.id);
                        },
                        labelPadding: EdgeInsets.zero,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        tabs: List.generate(
                            eventProvider.getEventNameList(context).length,
                            (index) {
                          return EventTabItem(
                            containerUnSelected: AppColors.transparentColor,
                            containerSelected: AppColors.whiteColor,
                            borderSelected: AppColors.transparentColor,
                            borderUnSelected: AppColors.whiteColor,
                            iconData: eventIcons[index],
                            eventName:
                                eventProvider.getEventNameList(context)[index],
                            isSelected: eventProvider.selectedIndex == index,
                            lightSelected: AppColors.blueColor,
                            darkSelected: AppColors.primaryColor,
                            baseUnselected: AppColors.whiteColor,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: eventProvider.filteredEventList.isEmpty
                ? Center(
                    child: Text("No events available"),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: eventProvider.filteredEventList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: EventPostItem(
                          event: eventProvider.filteredEventList[index],
                          showDeleteIcon: true,
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
