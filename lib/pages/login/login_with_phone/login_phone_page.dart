import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'login_phone_controller.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({Key? key}) : super(key: key);


  @override
  State<LoginPhonePage> createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoginPhoneController>(
        create: (context) => LoginPhoneController(),
        child: Consumer<LoginPhoneController>(
            builder: (BuildContext context, LoginPhoneController controller, _) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:  const BoxDecoration(
                    color: Colors.white
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [

                    if(controller.confirmCode == false)...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                        child: TextField(
                          controller: controller.phone,
                          maxLength: 19,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [MaskTextInputFormatter(
                              mask: '+## (##) #####-####',
                              filter: { "#": RegExp(r'[0-9]') },
                              type: MaskAutoCompletionType.lazy
                          )],
                          decoration: const InputDecoration(
                            hintText: '+## (##) #####-####',
                            labelText: 'Phone',
                          ),

                        ),
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                          onPressed: (){
                            controller.sendCode();
                          },
                          child: const Text(
                            'Confirmar Número',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                      ),
                    ]else...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                        child: TextField(
                          controller: controller.code,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskTextInputFormatter(
                              mask: '######',
                              filter: { "#": RegExp(r'[0-9]') },
                              type: MaskAutoCompletionType.lazy
                          )],
                          decoration: const InputDecoration(
                            hintText: '######',
                            labelText: 'Código de segurança',
                          ),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),),
                            onPressed: (){
                              controller.confirmSmsCode();
                            },
                            child:  Text(
                              'Confirmar Código de Segurança enviado para o número \n${controller.phone.text}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                            )
                        ),
                      ),
                    ]

                  ],
                ),

              );
            }),
      ),
    );
  }
}