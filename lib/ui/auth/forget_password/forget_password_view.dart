import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/language_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/ui/auth/forget_password/forget_password_view_model.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:event_app/utils/validators.dart';
import 'package:event_app/widgets/custom_button.dart';
import 'package:event_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = "ForgetPassword";
  ForgetPasswordViewModel viewModel = ForgetPasswordViewModel();

  ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.forget_password,
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
                key: viewModel.formKey,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.03,
                        ),
                        child: Center(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.forgotPasswordImg,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                CustomTextFormField(
                                  controller: viewModel.emailController,
                                  hint: AppLocalizations.of(context)!.email,
                                  iconPath: AppAssets.emailIcon,
                                  iconColor: themeProvider.currentTheme ==
                                          ThemeMode.light
                                      ? AppColors.grey2
                                      : AppColors.whiteColor,
                                  hintStyle: themeProvider.currentTheme ==
                                          ThemeMode.light
                                      ? AppStyles.bold14Gray
                                      : AppStyles.bold14White,
                                  enableBorderColor: AppColors.grey2,
                                  focusBorderColor:
                                      themeProvider.currentTheme ==
                                              ThemeMode.light
                                          ? AppColors.blueColor
                                          : AppColors.primaryColor,
                                  validator: Validators.validateEmail,
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                CustomButton(
                                  text: AppLocalizations.of(context)!
                                      .reset_password,
                                  backgroundColor: AppColors.primaryColor,
                                  textColor: AppColors.whiteColor,
                                  onPressed: () {
                                    final emailError = Validators.validateEmail(
                                      viewModel.emailController.text,
                                    );
                                    if (emailError != null) {
                                      ToastUtils.showErrorToast(emailError);
                                    } else {
                                      viewModel.forgetPassword(context);
                                    }
                                  },
                                ),
                              ]),
                        ))))));
  }
}
