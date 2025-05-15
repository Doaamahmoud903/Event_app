import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/ui/auth/forget_password/forget_password_view.dart';
import 'package:event_app/ui/auth/login/login_view_model.dart';
import 'package:event_app/ui/auth/register/register_view.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/utils/app_styles.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:event_app/utils/validators.dart';
import 'package:event_app/widgets/custom_button.dart';
import 'package:event_app/widgets/custom_loading.dart';
import 'package:event_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/app_assets.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "LoginView";
  bool securePassword = true;
  LoginViewModel viewModel = LoginViewModel();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
        body: Stack(children: [
      GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: height * 0.05,
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
                              controller: viewModel.emailController,
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
                              controller: viewModel.passwordController,
                              keyboardType: TextInputType.visiblePassword,
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .forget_password_ques,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppColors.primaryColor)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(ForgetPassword.routeName);
                                    },
                                  ),
                                ]),
                            CustomButton(
                              text: AppLocalizations.of(context)!.login,
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor,
                              onPressed: () {
                                FocusScope.of(context).unfocus();

                                final emailError = Validators.validateEmail(
                                  viewModel.emailController.text,
                                );
                                final passwordError =
                                    Validators.validatePassword(
                                  viewModel.passwordController.text,
                                );

                                if (emailError != null) {
                                  ToastUtils.showErrorToast(emailError);
                                } else if (passwordError != null) {
                                  ToastUtils.showErrorToast(passwordError);
                                } else {
                                  viewModel.login(context);
                                }
                              },
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .dont_have_account,
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
                                      RegisterView.routeName,
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .create_account,
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
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.or,
                                  ),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            CustomButton(
                              onPressed: () {
                                viewModel.signInWithGoogle(context);
                              },
                              text: AppLocalizations.of(context)!
                                  .login_with_google,
                              textColor: AppColors.primaryColor,
                              fontSize: 18,
                              backgroundColor: AppColors.transparentColor,
                              borderColor: AppColors.grey2,
                              borderRadius: 12,
                              centerIcon: true,
                              icon: Image.asset(
                                AppAssets.googleIcon,
                                width: 24,
                                height: 24,
                              ),
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
                          ]))))),
      CustomLoadingItem(
        key: viewModel.loadingKey,
      ),
    ]));
  }
}
