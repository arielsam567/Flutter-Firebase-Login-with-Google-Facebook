import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/config/config.dart';
import 'package:login_firebase/pages/home/home_page.dart';
import 'package:login_firebase/pages/login/login_page.dart';
import 'package:login_firebase/services/storage.dart';

class SplashController extends ChangeNotifier{

  Future<void> init() async {
    await Firebase.initializeApp();
    await Storage.init();
    bool logged = Storage.storage!.getBool(Config.logged) ?? false;

    if(logged){
      Get.to( ( )=> const HomePage()); // look at this simplicity :)
    }else{
      Get.to( ( )=> const LoginPage()); // look at this simplicity :)
    }
  }

}