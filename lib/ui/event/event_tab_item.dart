import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class EventTabItem extends StatefulWidget {
  bool isSelected;
  String eventName;
  final IconData iconData;
  final Color lightSelected;
  final Color darkSelected;
  final Color baseUnselected;
  final Color containerSelected;
  final Color containerUnSelected;
  final Color borderSelected;
  final Color borderUnSelected;

  EventTabItem(
      {super.key,
      required this.isSelected,
      required this.eventName,
      required this.iconData,
      required this.lightSelected,
      required this.darkSelected,
      required this.baseUnselected,
      required this.containerSelected,
      required this.containerUnSelected,
      required this.borderSelected,
      required this.borderUnSelected});

  @override
  State<EventTabItem> createState() => _EventTabItemState();
}

class _EventTabItemState extends State<EventTabItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.01),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.01,
      ),
      decoration: BoxDecoration(
        color: widget.isSelected
            ? widget.containerSelected
            : widget.containerUnSelected,
        borderRadius: BorderRadius.circular(46),
        border: Border.all(
          color: widget.isSelected
              ? widget.borderSelected
              : widget.borderUnSelected,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(widget.iconData,
              size: 25,
              color: widget.isSelected
                  ? (themeProvider.currentTheme == ThemeMode.light
                      ? widget.lightSelected
                      : widget.darkSelected)
                  : widget.baseUnselected),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            widget.eventName,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isSelected
                    ? (themeProvider.currentTheme == ThemeMode.light
                        ? widget.lightSelected
                        : widget.darkSelected)
                    : widget.baseUnselected),
          )
        ],
      ),
    );
  }
}
