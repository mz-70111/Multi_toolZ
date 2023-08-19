import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
      result = json.decode(resp.body);
    } catch (e) {
      null;
    }
    return result;
  }

  getuserinfo({username}) async {
    List userMainInfo = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery': "select * from users where username='$username';"
        });

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
    DB.userinfotable.clear();
    DB.userinfotable.add([]);
    DB.userinfotable[0] = {
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
      DB.userinfotable[0]['office_priv'] = officepriv;
    }
  }
}
