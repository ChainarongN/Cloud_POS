import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

Column tabMenuTitle() {
  return Column(
    children: [
      TabBar(
        tabs: <Widget>[
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('เมนู', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#1', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Fav#2', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('Search', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('ส่วนลด', size: 16),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.adb_rounded, color: Colors.black, size: 20.0),
                AppTextStyle().textNormal('จ่ายเงิน', size: 16),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// Padding menuTitle(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(5),
//     child: SizedBox(
//       width: MediaQuery.of(context).size.width * 0.61,
//       height: MediaQuery.of(context).size.height * 0.1,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('เมนู', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('Fav#1', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('Fav#2', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('Search', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('ส่วนลด', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.09,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 margin: const EdgeInsets.only(right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Constants.secondaryColor,
//                       Constants.primaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Constants.primaryColor,
//                         blurRadius: 8,
//                         offset: Offset(0, 6)),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       const Icon(Icons.adb_rounded,
//                           color: Colors.black, size: 25.0),
//                       AppTextStyle().textNormal('จ่ายเงิน', size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
