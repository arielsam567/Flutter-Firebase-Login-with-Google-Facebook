import 'package:flutter/material.dart';
import 'package:login_firebase/pages/splash/splash_controller.dart';
import 'package:toast/toast.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  SplashController controller = SplashController();

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    Future.delayed(const Duration(seconds: 2), controller.init);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            Text(
              'SPLASH PAGE...\n\nCarregando dados do usuario...',
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40,),

            CircularProgressIndicator(color: Colors.black,)

          ],
        ),
      ),
    );
  }
}