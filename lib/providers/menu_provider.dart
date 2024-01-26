import 'package:flutter/material.dart';

import '../repositorys/repository.dart';

class MenuProvider extends ChangeNotifier {
  final IMenuRepository _menuRepository;
  MenuProvider(this._menuRepository);

  List get getOrderItem => _orderItem;
  List<String> get getListItem => _listItem;
  List<String> get getCategoryMenuTextList => _categoryMenuTextList;
  List get getMenuTextList => _menuTextList;

  addCountOrder(int index) {
    _orderItem[index]['count']++;
    notifyListeners();
  }

  removeCountOrder(int index) {
    if (_orderItem[index]['count'] > 1) {
      _orderItem[index]['count']--;
    }
    notifyListeners();
  }

  doSomething() {
    _menuRepository.getSomething();
  }

  final List<String> _listItem = [
    'เปลี่ยน',
    'แก้จำนวน',
    'ลบรายการ',
    'เลือกลบ',
    'หมายเหตุ',
    'การขาย',
    'ข้อมูลบิล',
    'พักบิล',
    'เงินด่วน'
  ];
  final List<String> _categoryMenuTextList = [
    'DI Amazon Bakery Factory-Warm',
    'DI Amazon Bakery Factory-Ambie',
    'DI Amazon Bakery Factory-Fersh',
    'DI Amazon Bakery Factory-Frozen',
    'DI Local Bakery by price',
    'DI NPD',
    'DI OEM Bakery เทศกาล (ให้คะแนน)',
  ];
  final List _menuTextList = [
    {"name": 'DI ครอฟเฟิลออริจินัล AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองดับเบิ้ลช็อกโกแลต AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองเนยสด AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ชามะนาวเย็น', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายคาโบนาร่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายทูน่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายผักขม AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายแอปเปิ้ลซินนามอน AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI เดนิชแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครอฟเฟิลชูการ์ AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครอฟเฟิลออริจินัล AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองดับเบิ้ลช็อกโกแลต AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองเนยสด AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายทูน่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายผักขม AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายแอปเปิ้ลซินนามอน AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI เดนิชแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ชามะนาวเย็น', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายคาโบนาร่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายทูน่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายผักขม AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายแอปเปิ้ลซินนามอน AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI เดนิชแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายทูน่า AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายผักขม AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI พายแอปเปิ้ลซินนามอน AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI เดนิชแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครอฟเฟิลชูการ์ AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครอฟเฟิลออริจินัล AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองดับเบิ้ลช็อกโกแลต AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองเนยสด AMZ', "image": "assets/coffee2.jpg"},
    {"name": 'DI ครัวซองแฮมชีส AMZ', "image": "assets/coffee2.jpg"},
  ];

  final List _orderItem = [
    {"price": "140", "count": 2, "name": "Hot Americano", "image": ""},
    {"price": "60", "count": 1, "name": "Americano", "image": ""},
    {"price": "60", "count": 1, "name": "Mocha", "image": ""},
  ];
}
