import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Floating_butt extends StatefulWidget {
  const Floating_butt({
    Key? key,
  }) : super(key: key);

  @override
  State<Floating_butt> createState() => _Floating_buttState();
}

class _Floating_buttState extends State<Floating_butt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: FloatingActionButton(
        backgroundColor: HexColor('#0000FF'),
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}

class BotBar extends StatelessWidget {
  const BotBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: HexColor('#0000FF'),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const MyXray()),
              //);
            },
          ),
          IconButton(
              icon: const Icon(Icons.upload_rounded, color: Colors.white),
              onPressed: () {})
        ],
      ),
    );
  }
}
