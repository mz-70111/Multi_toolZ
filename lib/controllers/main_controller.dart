// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends GetxController {
  waitcountdown() async {
    SplashScreen.waittime = 17;
    while (SplashScreen.waittime > 0) {
      await Future.delayed(
          const Duration(seconds: 1), () => SplashScreen.waittime--);
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
}
