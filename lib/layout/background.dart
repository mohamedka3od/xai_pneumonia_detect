import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
Widget backGround(BuildContext context, {required Widget widget})=>
    Container(
      width: double.infinity,
      color: Colors.white,
      child: ClipPath(
        clipper: BackgroundClipper(),
        child: Container(
          child: widget,
          width: double.infinity,
          decoration:  BoxDecoration(
            shape: BoxShape.rectangle,
            color: HexColor('#0000FF'),
          ),
        ),
      ),
    );
class BackgroundClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-(size.height/24));
    var firstStartBoint = Offset(size.width/2, size.height);
    var firstEndBoint = Offset(size.width, size.height-(size.height/24));
    path.quadraticBezierTo(firstStartBoint.dx, firstStartBoint.dy, firstEndBoint.dx, firstEndBoint.dy);

    path.lineTo(size.width,0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
