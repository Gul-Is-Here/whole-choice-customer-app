import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
// import 'package:whole_choice_customer/views/home-screens/home.dart';

import '../home-screens/home.dart';
import '../views/auth_screen/verify_phone.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  // textController
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //  Signup Method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //  Forget Password Reset

  // Storing user data in FireStore
  storeUserData({name, email, password, phone}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "password": password,
      "email": email,
      "phone": phone,
      "imageUrl": "",
      "id": currentUser!.uid,
      "cart_count": "00",
      "order_count": "00",
      "wishlist_count": "00"
    });
  }

  // SignOut Method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
  // Login With phone nummber

  phoneNumber(context) async {
    isLoading.value = true;
    await auth
        .verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: (_) {},
            verificationFailed: (e) {
              print(e.toString());
            },
            codeSent: (String verficationId, int? token) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return VerifyPhoneNumber(verificationId: verficationId);
              }));
            },
            codeAutoRetrievalTimeout: (e) {
              print(e.toString());
            })
        .onError((error, stackTrace) {
      print(error.toString());
      isLoading.value = false;
    });
  }

  void verifyPhoneNumber(String verificationID, context) async {
    isLoading.value = true;
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: verifyController.text.toString());
    try {
      await auth.signInWithCredential(credential);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const Home();
      }));
    } catch (e) {
      isLoading.value = false;
    }
  }
}
