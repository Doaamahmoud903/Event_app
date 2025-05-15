import 'package:flutter/material.dart';

class CustomContentRow extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String TimeOrDate;
  final Color TimeOrDateColor;
  final String iconPath;
  final Function()? selectTimeOrDate;

  const CustomContentRow(
      {super.key,
      required this.title,
      required this.TimeOrDate,
      required this.iconPath,
      required this.titleColor,
      required this.TimeOrDateColor,
      this.selectTimeOrDate});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: 20,
          height: 20,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: selectTimeOrDate,
          child: Text(
            TimeOrDate,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: TimeOrDateColor,
            ),
          ),
        ),
      ],
    );
  }
}
