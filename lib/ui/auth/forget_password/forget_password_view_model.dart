import 'package:event_app/ui/auth/login/login_view.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void forgetPassword(context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        ToastUtils.showSuccessToast("Password reset email sent.");
        //Navigator.of(context).pushNamed(LoginView.routeName);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        ToastUtils.showErrorToast(e.code);
      } catch (e) {
        ToastUtils.showErrorToast(e.toString());
      }
    }
  }
}
