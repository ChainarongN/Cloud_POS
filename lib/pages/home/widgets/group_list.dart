import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/widgets/container_style_2.dart';
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
          (index) => Container(
            margin: const EdgeInsets.all(2),
            child: homeWatch.getGroupItemValue == homeWatch.getGroupItem[index]
                ? ContainerStyle2(
                    onlyText: true,
                    title: homeWatch.getGroupItem[index],
                    icon: Icons.android,
                    size: 18,
                    radius: 8,
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.15,
                    shadowColor: Colors.blue.shade500,
                    gradient1: Colors.blue.shade400,
                    gradient2: Colors.blue.shade400,
                    gradient3: Colors.blue.shade600,
                    gradient4: Colors.blue.shade600,
                    onPressed: () {
                      homeRead.setGroupItemValue(homeWatch.getGroupItem[index]);
                    },
                  )
                : ContainerStyle2(
                    onlyText: true,
                    title: homeWatch.getGroupItem[index],
                    icon: Icons.android,
                    size: 18,
                    radius: 8,
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.15,
                    shadowColor: Colors.blueAccent.shade200,
                    gradient1: Colors.blue.shade100,
                    gradient2: Colors.blue.shade100,
                    gradient3: Colors.blue.shade300,
                    gradient4: Colors.blue.shade300,
                    onPressed: () {
                      homeRead.setGroupItemValue(homeWatch.getGroupItem[index]);
                    },
                  ),
          ),

          // GestureDetector(
          //   onTap: () {
          //     homeRead.setGroupItemValue(homeWatch.getGroupItem[index]);
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.1,
          //     height: MediaQuery.of(context).size.height * 0.15,
          //     padding: const EdgeInsets.all(5.0),
          //     margin: const EdgeInsets.all(2),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       gradient: LinearGradient(
          //         colors: homeWatch.getGroupItemValue ==
          //                 homeWatch.getGroupItem[index]
          //             ? [
          //                 const Color.fromARGB(255, 113, 134, 255),
          //                 const Color.fromARGB(255, 157, 198, 255),
          //               ]
          //             : [
          //                 const Color.fromARGB(255, 138, 196, 255),
          //                 const Color.fromARGB(255, 182, 212, 255),
          //               ],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       ),
          //       boxShadow: const [
          //         BoxShadow(
          //             color: Color.fromARGB(255, 182, 212, 255),
          //             blurRadius: 8,
          //             offset: Offset(0, 6)),
          //       ],
          //     ),
          //     child: Center(
          //         child: AppTextStyle().textBold(homeWatch.getGroupItem[index],
          //             size: 14, color: Colors.white)),
          //   ),
          // ),
        ),
      ),
    ),
  );
}
