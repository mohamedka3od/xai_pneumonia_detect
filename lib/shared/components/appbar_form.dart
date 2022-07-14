import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../style/colors.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Body', style: Theme.of(context).textTheme.headline4);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget firstIcon;
  final Widget child;
  final String title;
  final double height;
  final double childHeight;
  final Color color;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.height = 180.0,
    required this.childHeight,
    this.color = Colors.black,
    required this.firstIcon,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: preferredSize,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: <Widget>[
              ClipPath(
                clipper: _AppBarProfileClipper(height),
                child: Container(
                  width: double.maxFinite,
                  height: preferredSize.height - childHeight,
                  color: backGroundColor3,
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: <Widget>[
                      if (firstIcon != null) firstIcon,
                      if (firstIcon != null) Expanded(child: Container()),
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: const Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarProfileClipper extends CustomClipper<Path> {
  final double childHeight;

  _AppBarProfileClipper(this.childHeight);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height - 40.0);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40.0);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
