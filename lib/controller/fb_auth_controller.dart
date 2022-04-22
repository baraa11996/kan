import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kan/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../prefs/shared_prefs.dart';

typedef FbAuthStateListener = void Function({required bool status});

class FbAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  CollectionReference userref = FirebaseFirestore.instance.collection("user");

  Future<bool> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return true;
        } else {
          await userCredential.user!.sendEmailVerification();
          await signOut();
          showSnackBar(
            context: context,
            message: 'Email must be verified, check and try again!',
            error: true,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      _controlAuthException(context: context, exception: e);
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<bool> createAccount(
      {required BuildContext context,
      required String firstname,
      required String lastname,
      required String email,
      String? uId,
      required String date,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // UserModel model = UserModel(
      //   firstName: firstname,
      //   lastName: lastname,
      //   email: email,
      //   uId: uId!,
      //   image: 'https://img.freepik.com/free-photo/little-child-sitting-floor-pretty-smiling-surprised-boy-playing-with-wooden-cubes-home-conceptual-image-with-copy-negative-space_155003-38485.jpg?w=740',
      // );

      // FirebaseFirestore.instance.collection('users').doc(uId).set
      //   (
      //       model.toMap(),
      //   );

      await userref.doc(userCredential.user!.uid).set({
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "id": userCredential.user!.uid,
        "date": date,
        "image": ''
      });
      print(userCredential.user);
      await SharedPrefController().saveId(id: userCredential.user!.uid);

      await userCredential.user!.sendEmailVerification();
      await signOut();
      showSnackBar(
          context: context,
          message: 'Account created, verify email to start using app');
      return true;
    } on FirebaseAuthException catch (e) {
      _controlAuthException(context: context, exception: e);
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> forgetPassword(
      {required BuildContext context, required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showSnackBar(
          context: context,
          message: 'Password reset email sent, check your email');
      return true;
    } on FirebaseAuthException catch (e) {
      _controlAuthException(context: context, exception: e);
    }
    return false;
  }

  // bool get loggedIn => _firebaseAuth.currentUser != null;

  StreamSubscription checkUserState({required FbAuthStateListener listener}) {
    return _firebaseAuth.authStateChanges().listen((User? user) {
      print(user);
      listener(status: user != null);
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void _controlAuthException({
    required BuildContext context,
    required FirebaseAuthException exception,
  }) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'Error occurred!',
        error: true);
    if (exception.code == 'invalid-email') {
      //
    } else if (exception.code == 'user-disabled') {
      //
    } else if (exception.code == 'user-not-found') {
      //
    } else if (exception.code == 'wrong-password') {
      //
    } else if (exception.code == 'email-already-in-use') {
      //
    } else if (exception.code == 'operation-not-allowed') {
      //
    } else if (exception.code == 'weak-password') {
      //
    }
  }

  Future<bool> changePassword(
    BuildContext context, {
    required String currentPassword,
    required String newPassword,
  }) async {
    var user = _firebaseAuth.currentUser;

    user!.updatePassword(newPassword).then((_) {
      showSnackBar(
        context: context,
        message: 'Password changed successfully!',
        error: false,
      );
      return true;
    }).catchError((err) {
      showSnackBar(
        context: context,
        message: 'Error changing password!',
        error: true,
      );
      return false;
    });
    return false;
    // final cred = EmailAuthProvider.credential(
    //   email: user!.email!,
    //   password: currentPassword,
    // );
    // await user.reauthenticateWithCredential(cred).then((value) async {
    //   await user.updatePassword(newPassword).then((_) {
    //     showSnackBar(
    //       context: context,
    //       message: 'Password changed successfully!',
    //       error: false,
    //     );
    //     return true;
    //   }).catchError((error) {
    //     showSnackBar(
    //       context: context,
    //       // message: 'Error changing password!',
    //       message: error,
    //       error: true,
    //     );
    //     return false;
    //   });
    // });
    // return false;
  }
}
