import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("0000FF"),
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios_sharp,
            color: HexColor("FFFFFF"),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          'About',
          style: TextStyle(color: HexColor("FFFFFF")),
        ),
        centerTitle: true,
        backgroundColor: HexColor("0000FF"),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/lung.png',
              color: Colors.white,
              height: 100,
              width: 100,
            ),
          ),
          const Text('Pneumonia Detection',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          const Text('Version : 1.0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Divider(color: Colors.white ,indent: 20,endIndent: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            Text('Developed by :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text('    Mohamed Hashem Shokry',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text('    Mohamed Hashem El-Sayed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text('    Ahmed Samy Abdelsalam',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text('    Mohamed Yasser Abdullah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text('    Mohamed Nabil Mohamed',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text('    Mohamed Mahmoud Abdelmonem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],),
          const Divider(color: Colors.white ,indent: 20,endIndent: 20,),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:const [
               Text('Under supervision of:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text('    Dr/Amr Mohamed Abd Ellatif',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
