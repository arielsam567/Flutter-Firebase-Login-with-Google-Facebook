import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/config/config.dart';
import 'package:login_firebase/pages/login/login_page.dart';
import 'package:login_firebase/services/storage.dart';

class HomeController extends ChangeNotifier{

  HomeController(){
    init();
  }
  String email = '';

  Future<void> init() async{
    email = Storage.storage!.getString(Config.email)!;
    notifyListeners();
  }

  Future<void> logout() async{
    Storage.storage!.remove(Config.email);
    Storage.storage!.setBool(Config.logged, false);
    Get.off(()=> const LoginPage());
  }

}