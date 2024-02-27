// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// 
// import '../../../providers/provider.dart';
// 
// DropdownButtonFormField2<String> dropdownButton(
//     HomeProvider homeWatch, HomeProvider homeRead, String name) {
//   List<String> itemMap;
//   if (name == 'Category') {
//     itemMap = homeWatch.getCategoryItem;
//   } else {
//     itemMap = homeWatch.getServiceItem;
//   }
//   return DropdownButtonFormField2<String>(
//     isExpanded: true,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//     ),
//     hint: const Text(
//       'Select',
//       style: TextStyle(fontSize: 18),
//     ),
//     items: itemMap
//         .map((item) => DropdownMenuItem<String>(
//               value: item,
//               child: Text(
//                 item,
//                 style: const TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//             ))
//         .toList(),
//     onChanged: (value) {
//       if (name == 'Category') {
//         homeRead.setCategoryValue(value.toString());
//       } else {
//         homeRead.setServiceValue(value.toString());
//       }
//     },
//     buttonStyleData: const ButtonStyleData(
//       padding: EdgeInsets.only(right: 8),
//     ),
//     iconStyleData: const IconStyleData(
//       icon: Icon(
//         Icons.arrow_drop_down,
//         color: Colors.black45,
//       ),
//       iconSize: 24,
//     ),
//     dropdownStyleData: DropdownStyleData(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//       ),
//     ),
//     menuItemStyleData: const MenuItemStyleData(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//     ),
//   );
// }
