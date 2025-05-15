import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon, // Add icon property
    this.backgroundColor,
    this.width,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.margin,
    this.centerIcon,
    this.textStyle,
    this.height,
  });

  final VoidCallback? onPressed;
  final String text;
  final Widget? icon; // Define icon property
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin;
  final bool? centerIcon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        width: width ??
            (kIsWeb ? MediaQuery.of(context).size.width / 3 : double.infinity),
        height: height,
        child: MaterialButton(
          padding: kIsWeb ? const EdgeInsets.symmetric(vertical: 20) : padding,
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (icon != null) icon!,
              if (centerIcon == false) const Spacer(),
              SizedBox(width: icon != null ? 8.0 : 0),
              Text(
                text,
                style: textStyle ??
                    TextStyle(
                      fontSize: fontSize ?? 16,
                      color: textColor ?? Colors.black,
                      fontWeight: fontWeight ?? FontWeight.w700,
                    ),
              ),
              if (centerIcon == false) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
