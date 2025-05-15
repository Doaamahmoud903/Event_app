import 'package:event_app/modals/event_model.dart';
import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class EventPostItem extends StatelessWidget {
  final Event event;
  final bool showDeleteIcon;
  const EventPostItem({
    required this.event,
    super.key,
    required this.showDeleteIcon,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserDataProvider>(context);
    Color textColor = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.blueColor
        : AppColors.primaryColor;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Stack(
        children: [
          Image.asset(
            themeProvider.currentTheme == ThemeMode.light
                ? event.imageLight
                : event.imageDark,
            width: width,
            height: height * 0.25,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 4,
            left: 5,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text(
                    event.dateTime.day.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 4,
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01, vertical: height * 0.01),
                decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Provider.of<EventProvider>(context, listen: false)
                        .removeEvent(event.id);
                    Provider.of<EventProvider>(context, listen: false)
                        .getAllEvents(userProvider.currentUser!.id);
                  },
                  child: showDeleteIcon
                      ? ImageIcon(
                          AssetImage(AppAssets.deleteIcon),
                          color: AppColors.redColor,
                        )
                      : Container(),
                )),
          ),
          Positioned(
            right: 4,
            left: 4,
            bottom: 4,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).hoverColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.description,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.currentTheme == ThemeMode.light
                            ? AppColors.blackColor
                            : AppColors.whiteColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<EventProvider>(context, listen: false)
                          .toggleFavourite(
                              event, context, userProvider.currentUser!.id);
                    },
                    child: ImageIcon(
                      AssetImage(event.isFavourite
                          ? AppAssets.selectedLoveIcon
                          : AppAssets.loveIcon),
                      color: textColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
