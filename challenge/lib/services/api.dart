import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Api {
  static const baseUrk = "http://localhost:2000/api/";
  static addUser(Map pdata) async {
    print(pdata);
    var url = Uri.parse("${baseUrk}add");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        //
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        //
        print("failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getUser(Map pdata) async {
    print(pdata);
    var url = Uri.parse("${baseUrk}get");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        //
      } else {
        //
        print("failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
