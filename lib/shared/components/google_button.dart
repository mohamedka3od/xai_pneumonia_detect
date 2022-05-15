import 'package:flutter/material.dart';

import '../../modules/login/cubit/cubit.dart';

Widget googleButton(BuildContext context, {required String text, required Function()? onPressed})
=>SizedBox(
  height: 50,
  width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/4.3),
  child: MaterialButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Image(
          image: AssetImage('assets/images/google_logo.png'),
          fit:BoxFit.contain,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: FittedBox(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.blue,
              ),

            ),
          ),
        )
      ],
    ),
    shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey)
    ),
    elevation:5 ,
    color: Colors.white,
  ),
);