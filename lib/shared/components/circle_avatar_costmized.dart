// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// import '../../modules/app_screens/module/data/data.dart';
//
// class CircleAvatar extends StatelessWidget {
//   const CircleAvatar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       width: MediaQuery.of(context).size.width,
//       color: HexColor('#0000FF'),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               width: 5.0,
//               color: Colors.blue,
//             ),
//           ),
//           width: 100,
//           height: 100,
//           child: CircleAvatar(
//               backgroundColor: Colors.transparent,
//               child: SizedBox(
//                   width: 90,
//                   height: 90,
//                   child: ClipOval(
//                     child: Image.asset(
//                       Pro_Data().image,
//                     ),
//                   ))),
//         ),
//       ),
//     );
//   }
// }
