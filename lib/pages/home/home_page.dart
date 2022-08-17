import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
          builder: (BuildContext context, HomeController controller, _) {
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.amber
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Email: ${controller.email}'),
                    ElevatedButton(
                        onPressed: (){
                          controller.logout();
                        },
                        child: const Text(
                            'SAIR'
                        )
                    )
                  ],
                ),

              ),
            );
          }),
    );
  }
}