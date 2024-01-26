import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class APIService {
  APIService._internal();
  static final APIService _instance = APIService._internal();
  factory APIService() => _instance;

  Future post(String url, var data) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var dio = Dio();
    var response = await dio.request(
      url,
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(json.encode(response.data));
      return json.encode(response.data);
    } else {
      print('${response.statusCode} : ${response.statusMessage}');
    }
  }
}
