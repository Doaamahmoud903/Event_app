import 'package:event_app/firebase_utils.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modals/auth_model.dart';
import 'package:event_app/providers/language_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/auth/login/login_view.dart';
import 'package:event_app/ui/auth/register/register_view_model.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/utils/app_assets.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:event_app/utils/validators.dart' show Validators;
import 'package:event_app/widgets/custom_button.dart';
import 'package:event_app/widgets/custom_loading.dart';
import 'package:event_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  final GlobalKey<CustomLoadingItemState> loadingKey =
      GlobalKey<CustomLoadingItemState>();
  static const String routeName = "RegisterView";
  final emailController = TextEditingController(text: "doaa@gmail.com");
  final passwordController = TextEditingController(text: "123456");
  final confirmPasswordController = TextEditingController(text: "123456");
  final nameController = TextEditingController(text: "doaa");
  bool securePassword = true;
  final _formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();

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
            AppLocalizations.of(context)!.register,
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        body: Stack(children: [
          GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.03,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.logoSplash,
                                  height: height * 0.17,
                                  width: width * 0.8,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            CustomTextFormField(
                              controller: nameController,
                              hint: AppLocalizations.of(context)!.name,
                              iconPath: AppAssets.userIcon,
                              iconColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.grey2
                                      : AppColors.whiteColor,
                              hintStyle:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppStyles.bold14Gray
                                      : AppStyles.bold14White,
                              enableBorderColor: AppColors.grey2,
                              focusBorderColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.blueColor
                                      : AppColors.primaryColor,
                              validator: Validators.validateName,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              hint: AppLocalizations.of(context)!.email,
                              iconPath: AppAssets.emailIcon,
                              iconColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.grey2
                                      : AppColors.whiteColor,
                              hintStyle:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppStyles.bold14Gray
                                      : AppStyles.bold14White,
                              enableBorderColor: AppColors.grey2,
                              focusBorderColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.blueColor
                                      : AppColors.primaryColor,
                              validator: Validators.validateEmail,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              hint: AppLocalizations.of(context)!.password,
                              iconPath: AppAssets.lockIcon,
                              iconColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.grey2
                                      : AppColors.whiteColor,
                              hintStyle:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppStyles.bold14Gray
                                      : AppStyles.bold14White,
                              enableBorderColor: AppColors.grey2,
                              focusBorderColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.blueColor
                                      : AppColors.primaryColor,
                              obscure: true,
                              validator: Validators.validatePassword,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            CustomTextFormField(
                              controller: confirmPasswordController,
                              hint: AppLocalizations.of(context)!.re_password,
                              iconPath: AppAssets.lockIcon,
                              iconColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.grey2
                                      : AppColors.whiteColor,
                              hintStyle:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppStyles.bold14Gray
                                      : AppStyles.bold14White,
                              enableBorderColor: AppColors.grey2,
                              focusBorderColor:
                                  themeProvider.currentTheme == ThemeMode.light
                                      ? AppColors.blueColor
                                      : AppColors.primaryColor,
                              obscure: true,
                              validator: (value) =>
                                  Validators.validateConfirmPassword(
                                      value, passwordController.text),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CustomButton(
                              text:
                                  AppLocalizations.of(context)!.create_account,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor,
                              onPressed: () {
                                final emailError = Validators.validateEmail(
                                  emailController.text,
                                );
                                final passwordError =
                                    Validators.validatePassword(
                                  passwordController.text,
                                );

                                if (emailError != null) {
                                  ToastUtils.showErrorToast(emailError);
                                } else if (passwordError != null) {
                                  ToastUtils.showErrorToast(passwordError);
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  ToastUtils.showErrorToast(
                                      AppLocalizations.of(context)!
                                          .passwords_not_match);
                                } else {
                                  register(context);
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .have_account_ques,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themeProvider.currentTheme ==
                                            ThemeMode.light
                                        ? AppColors.darkBlueColor
                                        : AppColors.whiteColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      LoginView.routeName,
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (languageProvider.currentLocal == "en") {
                                      languageProvider.changeLocal("ar");
                                    } else {
                                      languageProvider.changeLocal("en");
                                    }
                                  },
                                  child: Image.asset(
                                    AppAssets.langSwitch,
                                    width: 74,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )))),
          CustomLoadingItem(
            key: loadingKey,
          ),
        ]));
  }

  void register(context) async {
    if (_formKey.currentState!.validate()) {
      viewModel.register(context, loadingKey, emailController.text,
          passwordController.text, nameController.text);
    }
  }
}
