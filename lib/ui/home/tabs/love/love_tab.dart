import 'package:event_app/providers/event_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_styles.dart';
import '../../../../widgets/event_post_item.dart';

class LoveTab extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Color themeColor = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.blueColor
        : AppColors.primaryColor;

    TextStyle hintTheme = themeProvider.currentTheme == ThemeMode.light
        ? AppStyles.bold14Blue
        : AppStyles.bold14Primary;
    var userProvider = Provider.of<UserDataProvider>(context);

    final lovedEvents = Provider.of<EventProvider>(context).favouriteEvents;
    if (lovedEvents.isEmpty) {
      Provider.of<EventProvider>(context)
          .getFavouriteEvents(userProvider.currentUser!.id);
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Center(
            child: CustomTextFormField(
              controller: searchController,
              hint: AppLocalizations.of(context)!.search_for_event,
              iconPath: AppAssets.searchIcon,
              iconColor: themeColor,
              hintStyle: hintTheme,
              enableBorderColor: themeColor,
              focusBorderColor: themeColor,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  //padding: const EdgeInsets.all(8.0),
                  child: EventPostItem(
                    event: lovedEvents[index],
                    showDeleteIcon: false,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.01);
              },
              itemCount: lovedEvents.length,
            ),
          )
        ],
      ),
    );
  }
}
