import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login_firebase/services/storage.dart';
import 'package:provider/provider.dart';

import 'pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            Storage.init();
          },
          lazy: false,
        ),
      ],
      child: const GetMaterialApp(
        title: 'Flutter Login - Firebase',
        home: SplashPage(),
      ),
    );
  }
}


