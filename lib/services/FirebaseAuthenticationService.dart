import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmail(BuildContext context, String email,
      String password, String confirmPassword, Function switchLoading) async {
    switchLoading();
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      switchLoading();
      return;
    }
    if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
      switchLoading();
      return;
    }
    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      switchLoading();
      return;
    }
    if (password.length < 6) {
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters long");
      switchLoading();
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushReplacementNamed('/init');
    } on PlatformException catch (e) {
      switchLoading();
      switchLoading();
      print(e.code);
      switch (e.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          Fluttertoast.showToast(
              msg: "This email is linked to an existing account");
          break;
        default:
          switchLoading();
          Fluttertoast.showToast(msg: "Error completing Registration");
      }
    } catch (e) {
      print(e);
      switchLoading();
    }
    switchLoading();
  }

  Future<void> loginWithEmail(BuildContext context, String email,
      String password, Function switchLoading) async {
    switchLoading();
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields.");
      switchLoading();
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      switchLoading();
      Navigator.of(context).pushReplacementNamed('/init');
    } on PlatformException catch (e) {
      switchLoading();
      switch (e.code) {
        case 'ERROR_WRONG_PASSWORD':
          Fluttertoast.showToast(msg: "Wrong Password");
          break;
        case 'ERROR_USER_NOT_FOUND':
          Fluttertoast.showToast(
              msg: "This email is not linked to any account");
          break;
        default:
          Fluttertoast.showToast(msg: "Authentication Problem");
      }
    } catch (e) {
      print(e);
      switchLoading();
    }
  }

  Future<void> logOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/init', (_) => false);
  }
}
