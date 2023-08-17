import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';

class DBController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await DB().createtables();
    update();
  }

  requestpost({url, data}) async {
    List? result;
    try {
      var resp = await http.post(Uri.parse(url), body: data);
      result = json.decode(resp.body);
    } catch (e) {
      null;
    }
    return result;
  }
}
