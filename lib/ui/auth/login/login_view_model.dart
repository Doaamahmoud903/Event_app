import 'package:event_app/firebase_utils.dart';
import 'package:event_app/modals/auth_model.dart';
import 'package:event_app/providers/user_data_provider.dart';
import 'package:event_app/ui/home/home_screen.dart';
import 'package:event_app/utils/toastUtils.dart';
import 'package:event_app/widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController(text: "doaa@gmail.com");
  final passwordController = TextEditingController(text: "123456");
  final GlobalKey<CustomLoadingItemState> loadingKey =
      GlobalKey<CustomLoadingItemState>();
  final formKey = GlobalKey<FormState>();

  void login(context) async {
    if (formKey.currentState!.validate()) {
      loadingKey.currentState?.show();
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (credential.user == null) {
          loadingKey.currentState?.hide();
          ToastUtils.showErrorToast("Login failed: User not found.");
          return;
        }
        var user =
            await FirebaseUtils.readUserFromDb(credential.user?.uid ?? '');
        //todo: save user to provider
        var userProvider =
            Provider.of<UserDataProvider>(context, listen: false);
        userProvider.setCurrentUser(user!);

        print("Usser: $user");
        if (user != null) {
          userProvider.setCurrentUser(user);
        } else {
          loadingKey.currentState?.hide();
          ToastUtils.showErrorToast("Login failed: User data is null.");
          return;
        }

        //todo: hide loading and show toast
        loadingKey.currentState?.hide();
        ToastUtils.showSuccessToast("Login successfully");
        ToastUtils.showSuccessToast("Login with Google successful");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        loadingKey.currentState?.hide();
        if (e.code == 'user-not-found') {
          ToastUtils.showErrorToast('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ToastUtils.showErrorToast('Wrong password provided for that user.');
        } else {
          ToastUtils.showErrorToast(e.code);
        }
      } catch (e) {
        print("Unexpected error: $e");
        loadingKey.currentState?.hide();
        ToastUtils.showErrorToast(e.toString());
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      ToastUtils.showErrorToast("Google authentication failed.");
      return;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        ToastUtils.showErrorToast("Google sign-in failed: User is null.");
        return;
      }

      // Check if user already exists in Firestore
      var existingUser = await FirebaseUtils.readUserFromDb(user.uid);

      if (existingUser == null) {
        // Create new user in Firestore
        var newUser = MyUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await FirebaseUtils.addUserToFirestore(newUser);
        existingUser = newUser;
      }

      // Save user to provider
      final userProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      userProvider.setCurrentUser(existingUser);

      ToastUtils.showSuccessToast("Login with Google successful");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', user.uid);

      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (e) {
      ToastUtils.showErrorToast("Google sign-in error: $e");
    }
  }
}
