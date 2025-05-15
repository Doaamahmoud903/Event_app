import 'package:event_app/firebase_utils.dart';
import 'package:event_app/modals/auth_model.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel extends ChangeNotifier {
  void register(
      context, loadingKey, String email, String password, String name) async {
    loadingKey.currentState!.show();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      MyUser user = MyUser(
        id: credential.user?.uid ?? "",
        name: name,
        email: email,
      );
      await FirebaseUtils.addUserToFirestore(user);
      loadingKey.currentState!.hide();
      ToastUtils.showSuccessToast("Registered successfully");
      ToastUtils.showSuccessToast("Login with Google successful");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      var userProvider = Provider.of<UserDataProvider>(context, listen: false);
      userProvider.setCurrentUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        loadingKey.currentState!.hide();
        ToastUtils.showErrorToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        loadingKey.currentState!.hide();
        ToastUtils.showErrorToast('The account already exists for that email.');
      } else {
        ToastUtils.showErrorToast(e.code);
      }
    } catch (e) {
      loadingKey.currentState!.hide();
      ToastUtils.showErrorToast(e.toString());
    }
  }
}
