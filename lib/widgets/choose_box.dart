import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ChooseBox extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String prefixIconPath;
  final Color prefixIconColor;
  final String suffixIconPath;
  final Color suffixIconColor;
  final Color borderColor;
  final Color containerColor;
  final VoidCallback onTap;

  const ChooseBox(
      {super.key,
      required this.title,
      required this.suffixIconColor,
      required this.containerColor,
      required this.titleColor,
      required this.prefixIconPath,
      required this.prefixIconColor,
      required this.suffixIconPath,
      required this.borderColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.9,
        height: height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: containerColor,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryColor,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.01,
                vertical: height * 0.01,
              ),
              child: Image.asset(
                prefixIconPath,
                color: prefixIconColor,
                width: 100,
                height: 100,
              ),
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
            Image.asset(
              suffixIconPath,
              width: 20,
              height: 20,
              color: suffixIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
