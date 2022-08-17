// import 'package:agenda_2_0/models/user_model.dart';
// import 'package:flutter/material.dart';
//
// class UserStore extends ChangeNotifier {
//   static UserModel? _user;
//
//   static UserModel? get user => _user;
//   static bool get authenticated => null != user;
//
//   static init() async {
//     try {
//       //setUser(await UserRepository.getLogged());
//     } catch (e) {
//       print('error UserStore.init ${e.toString()}');
//     }
//   }
//
//   static void setUser(UserModel user) {
//     _user = user;
//   }
//
//   void updateUser() {
//     notifyListeners();
//   }
// }
