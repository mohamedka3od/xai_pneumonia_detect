import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/login/login_screen.dart';
import 'package:xai_pneumonia_detect/modules/register/register_screen.dart';

import '../../shared/components/components.dart';

class LRScreen extends StatelessWidget {
  const LRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
    children:<Widget>[
    Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          HexColor('#00008F'),
          HexColor('#0000FF'),
        ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    ),
    Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 20,
          right: 20,
        ),
        child: Center(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/lung.png'),
                      width: MediaQuery.of(context).size.width/2,
                      height:MediaQuery.of(context).size.width/2,
                    ),
                     SizedBox(
                      height: height/80,
                    ),
                     Text(
                      'Pneumonia Detection',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      )
                    ),
                    SizedBox(
                      height: height/60,
                    ),
                     Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                        )
                    ),
                     SizedBox(
                      height: height/5,
                    ),
                    defaultButton(
                      text: 'Sign in',
                      width: MediaQuery.of(context).size.width/1.5,
                      function: () {
                        navigateTo(context, LoginScreen());
                      },
                    ),
                    SizedBox(
                      height: height/35,
                    ),
                    defaultButton(
                      text: 'Sign up',
                      width: MediaQuery.of(context).size.width/1.5,
                      function: () {
                        navigateTo(context, RegisterScreen());
                      },
                    ),

                  ],
                ),
          ),
        ),
      ),
    ),
      ],
    );
  }
}
