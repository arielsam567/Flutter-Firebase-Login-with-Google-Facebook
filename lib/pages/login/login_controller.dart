import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/config/config.dart';
import 'package:login_firebase/pages/home/home_page.dart';
import 'package:login_firebase/pages/login/login_with_phone/login_phone_page.dart';
import 'package:login_firebase/services/storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:toast/toast.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

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

      print("\email: ${userCredential.user!.email}\n");

      successToLogin(userCredential.user!.email!);
      goToHomePage();
    } catch (e) {
      Toast.show(
          'error $e',
          duration: 3,
          backgroundColor: Colors.red
      );
      print('error $e');
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      final fb = FacebookLogin();
      final FacebookLoginResult res = await fb.logIn(
          permissions: [
            FacebookPermission.publicProfile,
            FacebookPermission.email,
          ]
      );

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
          Toast.show(
              'error ${res.error}',
              duration: 3,
              backgroundColor: Colors.red
          );
          break;

        default:
        // Log in failed
          print('\n***\n***\nDefault while log in: ${res.error}');
          Toast.show(
              'error ${res.error}',
              duration: 3,
              backgroundColor: Colors.red
          );
          break;
      }
    } catch (e) {
      Toast.show(
          'error $e',
          duration: 3,
          backgroundColor: Colors.red
      );
      print('error $e');
    }
  }

  Future<void> loginWithApple() async {

    try {
      final  appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
      ],
          webAuthenticationOptions: WebAuthenticationOptions(
              clientId: 'com.ariel.login.com.firebase',
              redirectUri: Uri.parse(
                'https://flutter-login.glitch.me/callbacks/sign_in_with_apple',
              )
          )
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');

      final OAuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      successToLogin(userCredential.user!.email!);
      goToHomePage();

    } catch (e) {
      Toast.show(
          'error $e',
          duration: 3,
          backgroundColor: Colors.red
      );
      print('error $e');
    }
  }

  Future<void> loginWithTwitter() async {

    try {

      final twitterLogin = TwitterLogin(
        //Accress token 1559968401656799238-EPpvFWd2cAhWJnG2HAv85j0uQA9I3p
        //Access Token Secret 8s3zOfLUDNCarEcAR5vAuft4D5iuG9ivGuUGk7B1XlYuG
        apiKey: 'DS9S5DRLBAe6OsGiZSpTuIWsU',
        apiSecretKey: 'mnlexqam9DJosoGqSG0aEgd2RiZRT2HiJrDAFUfPX4zUApIiNm',
        redirectURI: 'arielsam://',
      );
      final AuthResult authResult = await twitterLogin.loginV2(forceLogin: true);
      switch (authResult.status!) {
        case TwitterLoginStatus.loggedIn:
          print('success ${authResult.user!.name}');
          successToLogin(authResult.user!.name);
          goToHomePage();
          break;
        case TwitterLoginStatus.cancelledByUser:
          print('error cancelledByUser ${authResult.errorMessage}');
          break;
        case TwitterLoginStatus.error:
          Toast.show(
              'error ${authResult.errorMessage}',
              duration: 3,
              backgroundColor: Colors.red
          );
          print('error ${authResult.errorMessage}');
          break;
      }

    } catch (e) {
      Toast.show(
          'error $e',
          duration: 3,
          backgroundColor: Colors.red
      );
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


  void goToLoginPhonePage(){
    Get.to(()=> const LoginPhonePage());
  }

}
