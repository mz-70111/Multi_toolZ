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

  getuserinfo() async {
    // List usermaininfo = await DBController().requestpost(
    //     url: "${InfoBasic.host}${InfoBasic.customquerypath}",
    //     data: {'customquery': "select * from users;"});
    // List user_privilege = await DBController().requestpost(
    //     url: "${InfoBasic.host}${InfoBasic.customquerypath}",
    //     data: {
    //       'customquery':
    //           "select * from users_prvileges where up_user_id=${usermaininfo[0]['user_id']};"
    //     });
    List users__priv_office = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.customquerypath}",
        data: {
          'customquery': "select * from users_priv_office where upo_user_id=1;"
        });
    print(users__priv_office);
    // DB.userinfotable.clear();
    // DB.userinfotable.add([]);
    // DB.userinfotable[0].add({
    //   'user_id': '${usermaininfo[0]['user_id']}',
    //   'username': '${usermaininfo[0]['username']}',
    //   'fullname': '${usermaininfo[0]['fullname']}',
    //   'email': '${usermaininfo[0]['email']}',
    //   'mobile': '${usermaininfo[0]['mobile']}',
    //   'admin': '${user_privilege[0]['admin']}',
    //   'enable': '${user_privilege[0]['enable']}',
    //   'mustchgpass': '${user_privilege[0]['mustchgpass']}',
    //   'pbx': '${user_privilege[0]['pbx']}',
    // });

    // if (users__priv_office != null) {
    //   for (var i in users__priv_office) {}
    //   DB.userinfotable[0].addAll({''});
    // }
  }
}
