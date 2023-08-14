import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_tools_mz/controllers/db_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DBController dbController = Get.find();
    var result, statuscode;

    return Scaffold(
      body: FutureBuilder(future: Future(() async {
        try {
          print('hi');
          var conn = await http
              .get(Uri.parse("http://192.168.30.8/lib/php_API/connect_db.php"));
          if (conn.statusCode == 200) {
            result = json.decode(conn.body);
            statuscode = conn.statusCode;
            print(statuscode);
          } else {
            statuscode = conn.statusCode;
            print(statuscode);
          }
        } catch (e) {
          print(e);
        }
      }), builder: (_, snap) {
        if (statuscode == 200) {
          return Text("$result");
        } else {
          return IconButton(
              onPressed: () {
                Get.offNamed('/');
              },
              icon: Icon(Icons.refresh));
        }
      }),
    );
  }
}
