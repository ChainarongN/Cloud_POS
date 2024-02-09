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
        ),
      ),
    ),
  );
}
