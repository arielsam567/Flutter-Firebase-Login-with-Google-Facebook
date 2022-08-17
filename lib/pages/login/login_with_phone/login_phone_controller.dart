import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/config/config.dart';
import 'package:login_firebase/pages/home/home_page.dart';
import 'package:login_firebase/services/storage.dart';
import 'package:toast/toast.dart';

class LoginPhoneController extends ChangeNotifier{
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();

  bool confirmCode = false;
  late String verificationId;

  void sendCode() {
    if (phone.text.isNotEmpty) {

      final phoneNumber = phone.text.trim();

      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (AuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException verificationId) {
          print('error FirebaseAuthException $verificationId');
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          this.verificationId = verificationId;
        },
      );

      confirmCode = true;
      notifyListeners();
    }else{
      Toast.show(
          'Número inválido',
          duration: 3,
          backgroundColor: Colors.red);
    }
  }

  confirmSmsCode() async {
    if (code.text.length == 6) {

      try {
        AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: code.text,
        );

        UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        if(userCredential.user != null){
          saveUserData(phone.text);
          goToHomePage();
        }
      } catch (e) {
        Toast.show(
            'Error $e',
            duration: 3,
            backgroundColor: Colors.red);
      }
    }
  }

  void saveUserData(String email){
    Storage.storage!.setString(Config.email, email);
    Storage.storage!.setBool(Config.logged, true);
  }

  void goToHomePage(){
    Get.offAll(()=> const HomePage());
  }

}
