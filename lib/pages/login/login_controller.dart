import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/config/config.dart';
import 'package:login_firebase/pages/home/home_page.dart';
import 'package:login_firebase/services/storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends ChangeNotifier{

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      print("\n\nfirebaseToken: ${userCredential.user!.email}");

      successToLogin(userCredential.user!.email!);
      goToHomePage();
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      final fb = FacebookLogin();

      final FacebookLoginResult res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:

          final FacebookAccessToken? accessToken = res.accessToken;

          final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(accessToken!.token);

          FirebaseAuth firebaseAuth = FirebaseAuth.instance;

          final UserCredential userCredential = await firebaseAuth.signInWithCredential(oAuthCredential);

          print("\n\nfirebaseToken: ${userCredential.user!.email}");

          successToLogin(userCredential.user!.email!);
          goToHomePage();
          break;

        case FacebookLoginStatus.cancel:
        // Log in failed
          print('\n***\n***\nCancel while log in: ${res.error}');
          break;

        case FacebookLoginStatus.error:
        // Log in failed
          print('\n***\n***\nError while log in: ${res.error}');
          break;

        default:
        // Log in failed
          print('\n***\n***\nDefault while log in: ${res.error}');
          break;
      }
    } catch (e) {
      print('error ${e}');
    }
  }

  Future<void> loginWithApple() async {

    try {
      final AuthorizationCredentialAppleID _appleCredential =
      await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');

      final OAuthCredential _credential = oAuthProvider.credential(
        idToken: _appleCredential.identityToken,
        accessToken: _appleCredential.authorizationCode,
      );

      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(_credential);

      successToLogin(userCredential.user!.email!);
      goToHomePage();

    } catch (e) {
      print('error $e');
    }
  }

  void successToLogin(String email){
    Storage.storage!.setString(Config.email, email);
    Storage.storage!.setBool(Config.logged, true);
  }

  void goToHomePage(){
    Get.off(()=> const HomePage());
  }

}
