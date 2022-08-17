import 'package:flutter/material.dart';
import 'package:login_firebase/widgets/button.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ChangeNotifierProvider<LoginController>(
        create: (context) => LoginController(),
        child: Consumer<LoginController>(
            builder: (BuildContext context, LoginController controller, _) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ButtonLogin(
                      onPressed: () => controller.loginWithGoogle,
                      text:'Login com Google',
                      buttonColor: Colors.white,
                      textColor: Colors.black,
                    ),

                    const SizedBox(height: 50,),

                    ButtonLogin(
                      onPressed: () => controller.loginWithFacebook,
                      text:'Login com Facebook',
                      buttonColor: Colors.blue,
                      textColor: Colors.white,
                    ),

                    const SizedBox(height: 50,),

                    ButtonLogin(
                      onPressed: () => controller.loginWithApple,
                      text:'Login com Apple',
                      buttonColor: Colors.black,
                      textColor: Colors.white,
                    ),

                    const SizedBox(height: 50,),

                    ButtonLogin(
                      onPressed: () => controller.goToLoginPhonePage,
                      text:'Login com Telefone',
                      buttonColor: Colors.white,
                      textColor: Colors.black,
                    ),

                    const SizedBox(height: 50,),

                    ButtonLogin(
                      onPressed: () => controller.loginWithTwitter,
                      text:'Login com Twitter',
                      buttonColor: Colors.blue,
                      textColor: Colors.white,
                    ),

                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}