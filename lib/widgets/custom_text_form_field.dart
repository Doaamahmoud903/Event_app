import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

typedef myValidator = String? Function(String?)?;

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? iconPath;
  final Color iconColor;
  final Color enableBorderColor;
  final Color focusBorderColor;
  final TextStyle hintStyle;
  final myValidator? validator;
  final bool obscure;
  final int? length;
  final int? lines;
  final TextInputType? keyboardType;

  CustomTextFormField({
    required this.controller,
    required this.hint,
    this.iconPath,
    required this.iconColor,
    required this.hintStyle,
    this.validator,
    this.lines = 1,
    this.length = 50,
    this.obscure = false,
    required this.enableBorderColor,
    required this.focusBorderColor,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool securePassword = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    Color themeColor = themeProvider.currentTheme == ThemeMode.light
        ? AppColors.blueColor
        : AppColors.primaryColor;

    return SizedBox(
      width: width * 0.9,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        style: TextStyle(
          fontSize: 14,
          color: themeProvider.currentTheme == ThemeMode.light
              ? AppColors.darkBlueColor
              : AppColors.whiteColor,
        ),
        maxLength: widget.length,
        maxLines: widget.lines,
        minLines: widget.lines,
        controller: widget.controller,
        obscureText: widget.obscure ? securePassword : false,
        obscuringCharacter: "*",
        validator: widget.validator,
        decoration: InputDecoration(
          counterText: "",

          enabledBorder: getInputDecoration(widget.enableBorderColor),
          focusedBorder: getInputDecoration(widget.focusBorderColor),
          errorBorder: getInputDecoration(AppColors.redColor),
          hintText: widget.hint,
          hintStyle: widget.hintStyle,
          prefixIcon: widget.iconPath != null
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: ImageIcon(
                    AssetImage(widget.iconPath!),
                    color: widget.iconColor,
                    size: 24,
                  ),
                )
              : null,
          suffixIcon: widget.obscure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      securePassword = !securePassword;
                    });
                  },
                  icon: Icon(
                    securePassword ? Icons.visibility_off : Icons.visibility,
                    color: widget.iconColor,
                  ),
                )
              : null,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(12),
          // ),
        ),
      ),
    );
  }

  OutlineInputBorder getInputDecoration(Color themeColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: themeColor,
        width: 1.4,
      ),
    );
  }
}
