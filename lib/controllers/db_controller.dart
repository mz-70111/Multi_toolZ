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
    await getversioninfo();
    update();
  }

  requestpost({url, data}) async {
    List? result;
    try {
      var resp = await http.post(Uri.parse(url), body: data);
      if (resp.statusCode == 200) {
        result = json.decode(resp.body);
      }
    } catch (e) {
      null;
    }
    return result;
  }

  gettableinfo({required List tablesname, required List infoqueries}) async {
    List clmnames = [];
    List result = [{}];

    for (var i in tablesname) {
      result[0].addAll({i: []});
      clmnames.add([]);
      List resp = await requestpost(
          url: "${InfoBasic.host}${InfoBasic.customquerypath}",
          data: {'customquery': ' desc $i;'});
      for (var j in resp) {
        clmnames[tablesname.indexOf(i)]!.add(j[0]);
      }
    }
    for (var i in infoqueries) {
      List? resp = await requestpost(
          url: "${InfoBasic.host}${InfoBasic.customquerypath}",
          data: {'customquery': infoqueries[infoqueries.indexOf(i)]});
      if (resp != null) {
        for (var j in resp) {
          result[0][tablesname[infoqueries.indexOf(i)]].add({});
          for (var o = 0; o < j.length; o++) {
            result[0][tablesname[infoqueries.indexOf(i)]][resp.indexOf(j)]
                .addAll({clmnames[infoqueries.indexOf(i)][o]: j[o]});
          }
        }
      }
    }

    return result;
  }

  getversioninfo() async {
    return await gettableinfo(tablesname: [
      'version'
    ], infoqueries: [
      'select * from version',
    ]);
  }

  getuserinfo({userid}) async {
    return await gettableinfo(tablesname: [
      'users',
      'users_privileges',
      'users_priv_office'
    ], infoqueries: [
      'select * from users where user_id=$userid;',
      'select * from users_privileges where up_user_id=$userid;',
      'select * from users_priv_office where upo_user_id=$userid;',
    ]);
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
