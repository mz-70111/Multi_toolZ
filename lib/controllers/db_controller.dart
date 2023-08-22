import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';

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
      if (resp.statusCode == 200) {
        result = json.decode(resp.body);
      }
    } catch (e) {}
    return result;
  }

  getuserinfo({userid}) async {
    List result = [];
    List userMainInfo = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {'customquery': "select * from users where user_id='$userid';"});
    List userPrivilege = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery':
              "select * from users_privileges where up_user_id=${userMainInfo[0]['user_id']};"
        });

    List usersPrivOffice = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery':
              "select * from users_priv_office where upo_user_id=${userMainInfo[0]['user_id']};"
        });
    result.add([]);
    result[0] = {
      'user_id': '${userMainInfo[0]['user_id']}',
      'username': '${userMainInfo[0]['username']}',
      'password': '${userMainInfo[0]['password']}',
      'fullname': '${userMainInfo[0]['fullname']}',
      'email': '${userMainInfo[0]['email']}',
      'mobile': '${userMainInfo[0]['mobile']}',
      'admin': '${userPrivilege[0]['admin']}',
      'enable': '${userPrivilege[0]['enable']}',
      'mustchgpass': '${userPrivilege[0]['mustchgpass']}',
      'pbx': '${userPrivilege[0]['pbx']}',
      'office_priv': []
    };
    if (usersPrivOffice.isNotEmpty) {
      List officepriv = [];
      officepriv.clear();
      for (var i in usersPrivOffice) {
        officepriv.add({});
        officepriv[usersPrivOffice.indexOf(i)] = {
          'office_id': i['upo_office_id'],
          'position': i['position'],
          'addtask': i['addtask'],
          'addtodo': i['addtodo'],
          'addremind': i['addremind'],
          'addemailtest': i['addemailtest']
        };
      }
      result[0]['office_priv'] = officepriv;
    }
    return result;
  }

  getallofficeinfo({userid}) async {
    List result = [];
    List officemain = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {'customquery': "select * from office;"});
    for (var i in officemain) {
      List officemain = await DBController().requestpost(
          url: "${InfoBasic.host}${InfoBasic.customquerypath}",
          data: {'customquery': "select * from office;"});
    }
  }

  changpass({userid, password}) async {
    await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery':
              "update users set password='$password' where user_id=$userid;"
        });
  }

  getlogsinfo() async {
    List result = [];
    List logs = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {'customquery': "select * from logs;"});
    for (var i in logs) {
      result.add([]);
      result[logs.indexOf(i)] = {
        'log_id': '${i['log_id']}',
        'log': '${i['log']}',
        'logdate': '${i['logdate']}',
        'visible': true
      };
    }

    return result;
  }
}
