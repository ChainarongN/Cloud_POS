import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/widgets/app_textstyle.dart';
import 'package:flutter/material.dart';

SizedBox detailGroupList(
    BuildContext context, HomeProvider homeWatch, HomeProvider homeRead) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.65,
    height: MediaQuery.of(context).size.height * 0.65,
    child: SingleChildScrollView(
      child: Wrap(
        spacing: 3,
        runSpacing: 5,
        children: List.generate(
          homeWatch.saleModeDataList!.length,
          (index) => GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, '/menuPage');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 138, 196, 255),
                    Color.fromARGB(255, 182, 212, 255),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 157, 198, 255),
                      blurRadius: 8,
                      offset: Offset(0, 6)),
                ],
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Icon(Icons.adb_rounded,
                      color: Colors.white, size: 35.0),
                  AppTextStyle().textBold(
                      homeWatch.saleModeDataList![index].saleModeName!,
                      color: Colors.white,
                      size: 16),
                ],
              )),
            ),
          ),
        ),
      ),
    ),
  );
}
// Expanded detailGroupList(HomeProvider homeWatch, HomeProvider homeRead) {
//   return Expanded(
//     child: GridView.extent(
//       childAspectRatio: (2 / 2),
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       padding: const EdgeInsets.all(8.0),
//       maxCrossAxisExtent: 200.0,
//       children: List.generate(homeWatch.getDetailGroupItem.length, (index) {
//         return GestureDetector(
//           onTap: () {
//             homeRead
//                 .setDetailGroupItemValue(homeWatch.getDetailGroupItem[index]);
//           },
//           child: Container(
//             padding: const EdgeInsets.all(5.0),
//             margin: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: homeWatch.getDetailGroupItemValue ==
//                       homeWatch.getDetailGroupItem[index]
//                   ? Border.all(color: Colors.blue.shade900)
//                   : Border.all(color: Constants.primaryColor),
//               color: homeWatch.getDetailGroupItemValue ==
//                       homeWatch.getDetailGroupItem[index]
//                   ? Constants.primaryColor
//                   : Constants.secondaryColor,
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
//                 AppTextStyle().textNormal(homeWatch.getDetailGroupItem[index]),
//               ],
//             )),
//           ),
//         );
//       }),
//     ),
//   );
// }
