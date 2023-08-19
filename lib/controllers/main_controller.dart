// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';
import 'package:url_launcher/url_launcher.dart';

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
      try {
        LogIn.loginwait = true;
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
                LogIn.passwordcontroller.text
              ]);
              LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
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
        LogIn.loginwait = false;
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
      try {
        LogIn.loginwait = true;
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
                LogIn.passwordcontroller.text
              ]);
              LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
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
        LogIn.loginwait = false;
      } catch (e) {
        LogIn.mainloginerrormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
    }
    LogIn.loginwait = false;
    update();
  }

  chgpassaction() async {
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
      try {
        List? userinfo = await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "select * from users where username='${LogIn.usernamecontroller.text.toLowerCase()}' and password='${codepassword(word: LogIn.passwordcontroller.text)}';"
            });
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "update users set password='${codepassword(word: LogIn.newpasswordcontroller.text)}' where username='${LogIn.usernamecontroller.text.toLowerCase()}';"
            });
        await DBController().requestpost(
            url: "${InfoBasic.host}${InfoBasic.customquerypath}",
            data: {
              'customquery':
                  "update users_privileges set mustchgpass=0 where up_user_id=${userinfo![0]['user_id']};"
            });
        await SharedPreMz.sharedPreMzSetLogin(
            login: [userinfo[0]['username'], LogIn.newpasswordcontroller.text]);
        LogIn.loginwait = false;
        LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin();
        Get.offNamed('/home');
      } catch (e) {
        LogIn.mainloginerrormsg =
            "${Lang.lang['mainloginerrormsg'][Lang.langlist.indexOf(Lang.selectlanguage)]}";
      }
      update();
    }
    update();
  }

  logout() async {
    await SharedPreMz.sharedPreferenceMM.remove('login');
    LogIn.usernamecontroller.text = LogIn.passwordcontroller.text = '';
    Get.offNamed('/login');
  }

  chgpassfrompresonal({ctx}) async {
    showDialog(
        context: ctx,
        builder: (_) {
          return Directionality(
            textDirection: Lang.selectlanguage == 'Ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: AlertDialog(
              title: Text(Lang.lang['changpasstitle']
                  [Lang.langlist.indexOf(Lang.selectlanguage)]),
            ),
          );
        });
    update();
  }

  navbaraction({x}) async {
    for (var i in BottomNavBarMz.bottomnavitem) {
      i['angle'] = 0.0;
      i['y'] = 0.0;
      i['backcolor'] = Colors.transparent;
      i['bordercolor'] = Colors.transparent;
    }
    BottomNavBarMz.bottomnavitem[x]['angle'] = 45.0;
    BottomNavBarMz.bottomnavitem[x]['y'] = -AppBar().preferredSize.height / 3;
    BottomNavBarMz.bottomnavitem[x]['backcolor'] =
        ThemeMz.mode == 'light' ? Colors.white : Colors.black;
    BottomNavBarMz.bottomnavitem[x]['bordercolor'] =
        ThemeMz.mode == 'light' ? Colors.deepPurple : Colors.amberAccent;
    BottomNavBarMz.selecteditem = x;
    update();
  }

  showpersonalinfo({ctx}) {}
}
