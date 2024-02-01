import 'package:cloud_pos/providers/home_provider.dart';
import 'package:cloud_pos/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Row addCustomer(
    BuildContext context, HomeProvider homeWatch, HomeProvider homeRead) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(Icons.person_4, color: Colors.black, size: 40.0),
      Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width * 0.11,
        child: TextField(
          controller: homeWatch.getCustomerValue,
          onChanged: (value) {
            homeRead.setCountText(value);
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: myinputborder(), //normal border
            enabledBorder: myinputborder(), //enabled border
            focusedBorder: myfocusborder(), //focused border
          ),
          style: const TextStyle(color: Constants.textColor, fontSize: 20),
        ),
      ),
      GestureDetector(
        onTap: () {
          homeRead.removeCount();
        },
        child: const Icon(Icons.remove_circle_outline,
            color: Colors.red, size: 45.0),
      ),
      const SizedBox(width: 18),
      GestureDetector(
        onTap: () {
          homeRead.addCount();
        },
        child: const Icon(Icons.add_circle_outline,
            color: Constants.primaryColor, size: 45.0),
      ),
    ],
  );
}

OutlineInputBorder myinputborder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.black),
  );
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.black),
  );
}
