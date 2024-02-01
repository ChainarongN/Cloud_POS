import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';

Container username(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    width: MediaQuery.of(context).size.width * 0.3,
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        labelText: "Username",
        border: Constants().myinputborder(), //normal border
        enabledBorder: Constants().myinputborder(), //enabled border
        focusedBorder: Constants().myfocusborder(), //focused border
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 25, right: 15),
          child: Icon(Icons.people),
        ),
      ),
      style: const TextStyle(color: Constants.textColor, fontSize: 20),
    ),
  );
}
