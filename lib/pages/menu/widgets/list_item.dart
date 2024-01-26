import 'package:cloud_pos/providers/provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

Column listItem(MenuProvider menuWatch, BuildContext context) {
  return Column(
    children: List.generate(
      menuWatch.getListItem.length,
      (index) => Container(
        width: MediaQuery.of(context).size.width * 0.055,
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: index == menuWatch.getListItem.length - 1
              ? const Border(
                  bottom: BorderSide(width: 1.5, color: Colors.transparent),
                )
              : Border(
                  bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
                ),
          boxShadow: [
            BoxShadow(
              color: Constants.secondaryColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(Icons.add_alert,
                color: Color.fromARGB(255, 21, 48, 70), size: 25.0),
            Text(
              menuWatch.getListItem[index],
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}
