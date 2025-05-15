import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

import '../utils/app_assets.dart';

List<IconData> eventIcons = [
  Bootstrap.grid, // all
  Bootstrap.bicycle, // sports
  Bootstrap.gift, // birthday
  Bootstrap.people, // meeting
  Bootstrap.controller, // Games
  Bootstrap.tools, // workShop
  Bootstrap.book, // bookClub
  Bootstrap.image, // exhibition
  Bootstrap.sun, // holiday
  Bootstrap.egg_fried, // eating
];

List<String> eventImgLight = [
  AppAssets.sportsLight,
  AppAssets.birthdayLight,
  AppAssets.meetingLight,
  AppAssets.gamesLight,
  AppAssets.workShopLight,
  AppAssets.bookClubLight,
  AppAssets.exhibitionLight,
  AppAssets.holidayLight,
  AppAssets.eatingLight,
];

List<String> eventImgDark = [
  AppAssets.sportsDark,
  AppAssets.birthdayDark,
  AppAssets.meetingDark,
  AppAssets.gamesDark,
  AppAssets.workShopDark,
  AppAssets.bookClubDark,
  AppAssets.exhibitionDark,
  AppAssets.holidayDark,
  AppAssets.eatingDark,
];
List<String> getEventNameList(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;
  return [
    localizations.all,
    localizations.sports,
    localizations.birthday,
    localizations.meeting,
    localizations.games,
    localizations.work_shop,
    localizations.book_club,
    localizations.exhibition,
    localizations.holiday,
    localizations.eating,
  ];
}
