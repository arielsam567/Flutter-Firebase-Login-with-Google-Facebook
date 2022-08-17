import 'package:flutter/material.dart';
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
      body: ChangeNotifierProvider<LoginController>(
        create: (context) => LoginController(),
        child: Consumer<LoginController>(
            builder: (BuildContext context, LoginController controller, _) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.green
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                        onPressed: (){
                          controller.loginWithGoogle();
                        },
                        child: const Text(
                          'Login com Google',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        )
                    ),

                    const SizedBox(height: 100,),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                        onPressed: (){
                          controller.loginWithFacebook();
                        },
                        child: const Text(
                          'Login com Facebook',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                    ),

                  ],
                ),

              );
            }),
      ),
    );
  }
}