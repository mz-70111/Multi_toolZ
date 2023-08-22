// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/pages/homepage.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/logs.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dialogmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as df;

class MainController extends GetxController {
  waitcountdown() async {
    for (var i = 0; i < 20; i++) {
      await Future.delayed(const Duration(seconds: 1), () {
        SplashScreen.waittime = Random().nextInt(4);
        switch (SplashScreen.waittime) {
          case 0:
            SplashScreen.waitcolor = Colors.greenAccent;
            break;
          case 1:
            SplashScreen.waitcolor = Colors.redAccent;
            break;
          case 2:
            SplashScreen.waitcolor = Colors.blueAccent;
            break;
          case 3:
            SplashScreen.waitcolor = Colors.yellowAccent;
            break;
          default:
        }
      });
      update();
    }
  }

  urllaunch({url}) async {
    try {
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication)) {
        throw Exception('لا يمكن الوصول للموقع $url');
      }
    } catch (e) {
      null;
    }
  }

  hideshowpasswordLogin() {
    LogIn.passwordvisible = LogIn.passwordvisible == true ? false : true;
    LogIn.iconvisible = LogIn.iconvisible == Icons.visibility_off
        ? Icons.visibility
        : Icons.visibility_off;
    update();
  }

  codepassword({required String word}) {
    String code = 'muoaz153';
    String aftercoded = '';
    for (var i = 0; i < word.length; i++) {
      inloop:
      for (var j = 0; j < code.length; j++) {
        if (j == code.length - 1) break inloop;
        aftercoded +=
            String.fromCharCode(word.codeUnitAt(i) + code.codeUnitAt(j));
        if (i == word.length - 1) {
          break inloop;
        } else {
          i++;
        }
      }
    }
    return aftercoded;
  }

  checklogin() async {
    LogIn.mainloginerrormsg = LogIn.loginerrormsg = null;
    update();
    if (LogIn.usernamecontroller.text.isEmpty ||
        LogIn.passwordcontroller.text.isEmpty) {
      LogIn.loginerrormsg =
          "${Lang.lang['loginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else {
      LogIn.loginwait = true;
      update();
      try {
        List? userinfo = await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "select * from users where username='${LogIn.usernamecontroller.text.toLowerCase()}' and password='${codepassword(word: LogIn.passwordcontroller.text)}';"
            });
        if (userinfo!.isNotEmpty) {
          List? accountstatus = await DBController().requestpost(
              url: "${InfoBasic.host}${InfoBasic.customquerypath}",
              data: {
                'customquery':
                    "select * from users_privileges where up_user_id='${userinfo[0]['user_id']}';"
              });
          if (accountstatus![0]['enable'] == '1') {
            if (accountstatus[0]['mustchgpass'] == '0') {
              await SharedPreMz.sharedPreMzSetLogin(login: [
                userinfo[0]['username'],
                LogIn.passwordcontroller.text,
                userinfo[0]['user_id']
              ]);
              LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
              DB.userinfotable =
                  await DBController().getuserinfo(userid: LogIn.userinfo![2]);
              Get.offNamed('/home');
            } else {
              LogIn.chgpassvis = true;
            }
          } else {
            LogIn.mainloginerrormsg =
                "${Lang.lang['accountdisable'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
          }
        } else {
          LogIn.mainloginerrormsg =
              "${Lang.lang['mainloginerrormsgfaillogin'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
        }
      } catch (e) {
        LogIn.mainloginerrormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    LogIn.loginwait = false;
    update();
  }

  autologin() async {
    if (SharedPreMz.sharedPreMzGetLogin() != null) {
      LogIn.usernamecontroller.text = SharedPreMz.sharedPreMzGetLogin()[0];
      LogIn.passwordcontroller.text = SharedPreMz.sharedPreMzGetLogin()[1];
      LogIn.loginwait = true;
      update();
      try {
        List? userinfo = await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "select * from users where username='${LogIn.usernamecontroller.text.toLowerCase()}' and password='${codepassword(word: LogIn.passwordcontroller.text)}';"
            });
        if (userinfo!.isNotEmpty) {
          List? accountstatus = await DBController().requestpost(
              url: "${InfoBasic.host}${InfoBasic.customquerypath}",
              data: {
                'customquery':
                    "select * from users_privileges where up_user_id='${userinfo[0]['user_id']}';"
              });
          if (accountstatus![0]['enable'] == '1') {
            if (accountstatus[0]['mustchgpass'] == '0') {
              LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
              DB.userinfotable =
                  await DBController().getuserinfo(userid: LogIn.userinfo![2]);
              Get.offNamed('/home');
            } else {
              LogIn.chgpassvis = true;
            }
          } else {
            LogIn.mainloginerrormsg =
                "${Lang.lang['accountdisable'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
          }
        } else {
          LogIn.mainloginerrormsg =
              "${Lang.lang['mainloginerrormsgfaillogin'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
        }
      } catch (e) {
        LogIn.mainloginerrormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    LogIn.loginwait = false;
    update();
  }

  mustchgpass() async {
    LogIn.mainloginerrormsg = LogIn.loginerrormsg = null;
    if (LogIn.newpasswordcontroller.text.isEmpty) {
      LogIn.loginerrormsg =
          "${Lang.lang['checkemptynewpass'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else if (LogIn.newpasswordcontroller.text !=
        LogIn.newpasswordconfirmcontroller.text) {
      LogIn.loginerrormsg =
          "${Lang.lang['passwordnotmatch'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else {
      LogIn.loginwait = true;
      update();
      try {
        List userinfo = await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "select * from users where username='${LogIn.usernamecontroller.text.toLowerCase()}';"
            });
        await DBController().changpass(
            userid: userinfo[0]['user_id'],
            password: codepassword(word: LogIn.newpasswordcontroller.text));
        await SharedPreMz.sharedPreMzSetLogin(login: [
          userinfo[0]['username'],
          LogIn.newpasswordcontroller.text,
          userinfo[0]['user_id']
        ]);
        LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
        DB.userinfotable =
            await DBController().getuserinfo(userid: LogIn.userinfo![2]);
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "update users_privileges set mustchgpass=0 where up_user_id=${userinfo[0]['user_id']};"
            });
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "insert into logs set log='${DB.userinfotable[0]['username']} edit his password',logdate='${DateTime.now()}';"
            });
        Get.offNamed('/home');
      } catch (e) {
        LogIn.mainloginerrormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    LogIn.loginwait = false;
    update();
  }

  logout() async {
    await SharedPreMz.sharedPreferenceMM.remove('login');
    LogIn.usernamecontroller.text = LogIn.passwordcontroller.text = '';
    LogIn.newpasswordconfirmcontroller.text =
        LogIn.newpasswordcontroller.text = '';
    LogIn.chgpassvis = false;
    Get.offNamed('/login');
  }

  navbaraction({x}) async {
    try {
      HomePage.lastpageindex =
          BottomNavBarMz.selectedlist.indexWhere((element) => element == true);
    } catch (e) {}
    for (var o = 0; o < BottomNavBarMz.selectedlist.length; o++) {
      BottomNavBarMz.selectedlist[o] = false;
    }
    BottomNavBarMz.selectedlist[x] = true;
    switch (x) {
      case 0:
        Get.toNamed('/home');
        break;
      case 2:
        Get.toNamed('/logs');
        break;
      default:
    }
    update();
  }

  checkpassword({password}) {
    if (DB.userinfotable[0]['password'] == password) {
      return true;
    } else {
      return false;
    }
  }

  checkpasswordforpersonal({password}) {
    DialogMz.errormsg = null;
    bool check = checkpassword(password: codepassword(word: password));
    check == true
        ? {
            DialogMz.textfieldvisible = false,
            DialogMz.action2visible = true,
          }
        : DialogMz.errormsg =
            Lang.lang['wrongpass'][Lang.langlist.indexOf(Lang.selectlanguage)];
    update();
  }

  changepasswordpersonal(
      {required String newpass, required String newpassconfirm}) async {
    DialogMz.errormsg = null;
    if (newpass.isEmpty) {
      DialogMz.errormsg =
          "${Lang.lang['checkemptynewpass'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else if (newpass != newpassconfirm) {
      DialogMz.errormsg =
          "${Lang.lang['passwordnotmatch'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else {
      DialogMz.wait = true;
      update();
      try {
        await DBController().changpass(
            userid: DB.userinfotable[0]['user_id'],
            password: codepassword(word: newpass));
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "update users_privileges set mustchgpass=0 where up_user_id=${DB.userinfotable[0]['user_id']};"
            });
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "insert into logs set log='${DB.userinfotable[0]['username']} edit his password',logdate='${DateTime.now()}';"
            });
        DialogMz.wait = false;
        Get.back();
        logout();
      } catch (e) {
        DialogMz.errormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    update();
  }

  hideshowpasswordchgpass() {
    DialogMz.obscureText = DialogMz.obscureText == true ? false : true;
    update();
  }

  chooseselectedinfo(x) {
    for (var o = 0; o < DialogMz.selectedlist.length; o++) {
      DialogMz.selectedlist[o] = false;
    }
    DialogMz.selectedlist[x] = true;
    print(DialogMz.selectedlist);
    update();
  }

  updatepesonalinfo({fullname, mobile, email}) async {
    DialogMz.errormsg = null;
    if (fullname.isEmpty) {
      DialogMz.errormsg =
          "${Lang.lang['fullnamecheckempty'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
    } else {
      DialogMz.wait = true;
      update();
      try {
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "update users set fullname='$fullname',mobile='$mobile',email='$email' where user_id=${DB.userinfotable[0]['user_id']};"
            });
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "insert into logs set log='${DB.userinfotable[0]['username']} edit personal Info As fullname=$fullname,mobile=$mobile,email=$email',logdate='${DateTime.now()}';"
            });
        DB.userinfotable = await DBController()
            .getuserinfo(userid: DB.userinfotable[0]['user_id']);

        Get.back();
      } catch (e) {
        DialogMz.errormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    DialogMz.wait = false;
    update();
  }

  search(
      {word,
      list,
      required List<String> range,
      firstdate,
      lastdate,
      datelist,
      columnname}) {
    for (var t in list) {
      t['visible'] = false;
    }
    for (var i in list) {
      for (var r in range) {
        if (i[r.toLowerCase()].contains(word.toLowerCase())) {
          if (datelist != null) {
            for (var i in datelist) {
              if ((DateTime.parse(firstdate)
                          .isBefore(DateTime.parse(i[columnname])) ||
                      df.DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(firstdate)) ==
                          df.DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(i[columnname]))) &&
                  (DateTime.parse(lastdate)
                          .isAfter(DateTime.parse(i[columnname])) ||
                      df.DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(lastdate)) ==
                          df.DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(i[columnname])))) {
                i['visible'] = true;
              }
            }
          } else {
            i['visible'] = true;
          }
        }
      }
    }
    update();
  }

  setdate1({x, y, mainlist, sublist, columnname}) async {
    Logs.datevalue1 = x;
    for (var t in mainlist) {
      t['visible'] = false;
    }
    for (var i in mainlist) {
      if ((DateTime.parse(sublist[x.toInt()])
                  .isBefore(DateTime.parse(i[columnname])) ||
              df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(sublist[x.toInt()])) ==
                  df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i[columnname]))) &&
          ((DateTime.parse(sublist[y.toInt()])
                  .isAfter(DateTime.parse(i[columnname])) ||
              df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(sublist[y.toInt()])) ==
                  df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i[columnname]))))) {
        i['visible'] = true;
      }
    }
    update();
  }

  setdate2({x, y, mainlist, sublist, columnname}) async {
    Logs.datevalue2 = x;
    for (var t in mainlist) {
      t['visible'] = false;
    }
    for (var i in mainlist) {
      if ((DateTime.parse(sublist[x.toInt()])
                  .isAfter(DateTime.parse(i[columnname])) ||
              df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(sublist[x.toInt()])) ==
                  df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i[columnname]))) &&
          ((DateTime.parse(sublist[y.toInt()])
                  .isBefore(DateTime.parse(i[columnname])) ||
              df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(sublist[y.toInt()])) ==
                  df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i[columnname]))))) {
        i['visible'] = true;
      }
    }
    update();
  }
}
