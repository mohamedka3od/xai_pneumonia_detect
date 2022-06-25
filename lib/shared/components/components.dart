import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
//////////////////////////////////////////////////
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
//////////////////////////////////////////////////
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  required IconData prefix,
  Color borderColor = Colors.white,
  Color iconColor = Colors.black38,
  Color labelColor = Colors.black38,
  double elevation = 5,
  bool isPassword = false,
  Function(String)? onSubmit,
  IconData? suffix,
  Function? suffixPressed,
  Function()? onTap,
  bool isAutofocus = false,
}) =>
    Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      elevation: elevation,
      child: TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: type,
        obscureText: isPassword,
        autofocus:  isAutofocus,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          errorStyle: const TextStyle(
            // fontSize: 9,
            height: .5
          ),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          // labelText: label,
          hintText: label,

          hintStyle:TextStyle(color: labelColor),
          prefixIcon: Icon(
            prefix,
            color:iconColor,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () => suffixPressed!(),
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
        ),

      ),
    );
////////////////////////////////////////////////////

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.white,
  bool isUpperCase = true,
  double radius = 50,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 45.0,
      child: MaterialButton(
        elevation: 5,
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style:  TextStyle(
            color: HexColor('#0000FF'),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
//////////////////////////////////////////////////

Widget defaultTextButton({
  required Function()? function,
  required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));
///////////////////////////////////////////////////

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
//enum
enum ToastStates { SUCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
