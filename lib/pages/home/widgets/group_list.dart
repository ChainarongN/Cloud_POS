import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

SizedBox groupList(
    BuildContext context, HomeProvider homeWatch, HomeProvider homeRead) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.65,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          homeWatch.getGroupItem.length,
          (index) => GestureDetector(
            onTap: () {
              homeRead.setGroupItemValue(homeWatch.getGroupItem[index]);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    homeWatch.getGroupItemValue == homeWatch.getGroupItem[index]
                        ? Border.all(color: Colors.blue.shade900)
                        : Border.all(color: Constants.primaryColor),
                color:
                    homeWatch.getGroupItemValue == homeWatch.getGroupItem[index]
                        ? Constants.primaryColor
                        : Constants.secondaryColor,
                boxShadow: const [
                  BoxShadow(
                      color: Constants.primaryColor,
                      blurRadius: 8,
                      offset: Offset(0, 6)),
                ],
              ),
              child: Center(
                  child: AppTextStyle().textNormal(homeWatch.getGroupItem[index])),
            ),
          ),
        ),
      ),
    ),
  );
}

// Expanded groupList(HomeProvider homeWatch, HomeProvider homeRead) {
//   return Expanded(
//     child: GridView.extent(
//       childAspectRatio: (2 / 2),
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       padding: const EdgeInsets.all(10.0),
//       maxCrossAxisExtent: 200.0,
//       children: List.generate(homeWatch.getGroupItem.length, (index) {
//         return GestureDetector(
//           onTap: () {
//             homeRead.setGroupItemValue(homeWatch.getGroupItem[index]);
//           },
//           child: Container(
//             padding: const EdgeInsets.all(5.0),
//             margin: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border:
//                   homeWatch.getGroupItemValue == homeWatch.getGroupItem[index]
//                       ? Border.all(color: Colors.blue.shade900)
//                       : Border.all(color: Constants.primaryColor),
//               color:
//                   homeWatch.getGroupItemValue == homeWatch.getGroupItem[index]
//                       ? Constants.primaryColor
//                       : Constants.secondaryColor,
//               boxShadow: const [
//                 BoxShadow(
//                   color: Constants.secondaryColor,
//                   offset: Offset(0, 10),
//                   blurRadius: 30,
//                 ),
//               ],
//             ),
//             child: Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 const Icon(Icons.adb_rounded,
//                     color: Colors.black54, size: 35.0),
//                 AppTextStyle().textNormal(homeWatch.getGroupItem[index]),
//               ],
//             )),
//           ),
//         );
//       }),
//     ),
//   );
// }
