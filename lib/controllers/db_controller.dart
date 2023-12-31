import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_tools_mz/pages/office.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dialogmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';

class DBController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    try {
      await DB().createtables();
    } catch (e) {
      null;
    }
    await getversioninfo();
    update();
  }

  requestpost({url, data}) async {
    InfoBasic.error = null;
    var result;
    var resp = await http.post(Uri.parse(url), body: data);
    if (resp.statusCode == 200) {
      result = json.decode(resp.body);
    }
    try {
      if (result['status'] != 'done') {
        InfoBasic.error = result['status'];
      }
    } catch (e) {}
    return result;
  }

  gettableinfo({required List tablesname, required List infoqueries}) async {
    List clmnames = [];
    List result = [{}];
    for (var i in tablesname) {
      result[0].addAll({i: []});
      clmnames.add([]);
      List? resp = await requestpost(
          url: "${InfoBasic.host}${InfoBasic.selecttable}",
          data: {'customquery': ' desc $i;'});
      if (resp != null) {
        for (var j in resp) {
          clmnames[tablesname.indexOf(i)]!.add(j[0]);
        }
      }
    }
    for (var i in infoqueries) {
      List? resp = await requestpost(
          url: "${InfoBasic.host}${InfoBasic.selecttable}",
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
    for (var i = 0; i < result[0][tablesname[0]].length; i++) {
      result[0][tablesname[0]][i]
          .addAll({'visible': true, 'visiblesearch': true});
    }

    return result;
  }

  getversioninfo() async {
    try {
      return await gettableinfo(tablesname: [
        'version'
      ], infoqueries: [
        'select * from version',
      ]);
    } catch (e) {}
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

  getallusersinfotable() async {
    return await gettableinfo(tablesname: [
      'users',
      'users_privileges',
      'users_priv_office'
    ], infoqueries: [
      'select * from users;',
      'select * from users_privileges;',
      'select * from users_priv_office;',
    ]);
  }

  getofficeinfotable({officeid}) async {
    return await gettableinfo(tablesname: [
      'office',
      'users_priv_office'
    ], infoqueries: [
      'select * from office where office_id=$officeid;',
      'select * from users_priv_office where upo_office_id=$officeid;',
    ]);
  }

  getallofficeinfotable() async {
    return await gettableinfo(tablesname: [
      'office',
      'users_priv_office'
    ], infoqueries: [
      'select * from office;',
      'select * from users_priv_office;',
    ]);
  }

  changpass({userid, password}) async {
    var t = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.curdtable}",
        data: {
          'customquery':
              "update users set password='$password' where user_id=$userid;"
        });
    print(t);
  }

  getlogsinfo() async {
    List result = [];
    List logs = await DBController().requestpost(
        url: "${InfoBasic.host}${InfoBasic.selecttable}",
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
