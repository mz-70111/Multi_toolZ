import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/chat_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

MainController mainController = Get.find();
ThemeController themeController = Get.find();

class BottomNavBarMz extends StatelessWidget {
  const BottomNavBarMz({super.key});
  static int selecteditem = 0;
  static int? notifinum;
  static List selectedlist = [];
  @override
  Widget build(BuildContext context) {
    List bottomnavitem() => [
          {
            'visible': true,
            'icon': Icons.home,
            'action': () => mainController.navbaraction(x: 0),
            'index': 0,
            'size': 1,
          },
          {
            'visible': true,
            'icon': Icons.chat,
            'action': () async => await mainController.navbaraction(x: 1),
            'index': 1,
            'size': 1,
            'notifi': 'ok'
          },
          {
            'visible': DB.userinfotable[0]['admin'] == '1' ? true : false,
            'icon': Icons.report,
            'action': () => mainController.navbaraction(x: 2),
            'index': 2,
            'size': 1,
          }
        ];
    if (selectedlist.isEmpty) {
      selectedlist.clear();
      for (var i = 0; i < bottomnavitem().length; i++) {
        if (i == 0) {
          selectedlist.add(true);
        } else {
          selectedlist.add(false);
        }
      }
    }
    ChatController chatController = Get.find();
    return Container(
        decoration: BoxDecoration(
          color: ThemeMz.mode == 'light' ? Colors.white54 : Colors.black54,
          border: Border.all(
              color: ThemeMz.mode == 'light'
                  ? Colors.deepPurple
                  : Colors.amberAccent),
        ),
        height: AppBar().preferredSize.height,
        child: GetBuilder<MainController>(
            init: mainController,
            builder: (_) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...bottomnavitem().where((e) => e['visible'] == true).map(
                        (e) => TweenMz.rotate(
                            durationinmilliseconds: 300,
                            end: selectedlist[e['index']] == true ? 45.0 : 0.0,
                            child: TweenMz.translatey(
                                end: selectedlist[e['index']] == true
                                    ? -AppBar().preferredSize.height / 3
                                    : 0.0,
                                child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: selectedlist[e['index']] ==
                                                      true
                                                  ? ThemeMz.mode == 'light'
                                                      ? Colors.deepPurple
                                                      : Colors.amberAccent
                                                  : Colors.transparent,
                                              offset: const Offset(2, 2))
                                        ],
                                        color: selectedlist[e['index']] == true
                                            ? ThemeMz.mode == 'light'
                                                ? Colors.white
                                                : Colors.black
                                            : Colors.transparent,
                                        border: Border.all(
                                          width: 2,
                                          color:
                                              selectedlist[e['index']] == true
                                                  ? ThemeMz.mode == 'light'
                                                      ? Colors.deepPurple
                                                      : Colors.amberAccent
                                                  : Colors.transparent,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.elliptical(10, 5))),
                                    height: 50,
                                    width: 50,
                                    child: TweenMz.rotate(
                                        durationinmilliseconds: 300,
                                        end: selectedlist[e['index']] == true
                                            ? -45.0
                                            : 0.0,
                                        child: IconButton(
                                          icon: Stack(children: [
                                            Icon(
                                              e['icon'],
                                              color: ThemeMz.mode == 'light'
                                                  ? Colors.deepPurple
                                                  : Colors.yellowAccent,
                                            ),
                                            innerChatnotifibuilder(
                                                chatController, e)
                                          ]),
                                          onPressed: e['action'],
                                        ))))))
                  ]);
            }));
  }

  innerChatnotifibuilder(ChatController chatController, e) {
    return StreamBuilder(
        stream: Stream.periodic(
            const Duration(seconds: 2),
            (a) async => notifinum = await chatController.getchatnotifi(
                reciverid: LogIn.userinfo![2])),
        builder: (_, snap) {
          if (snap.hasData && e['notifi'] != null && notifinum != null) {
            return Transform.translate(
                offset: const Offset(-20.0, -20.0),
                child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(notifinum! > 0 ? "$notifinum" : "",
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white))));
          } else {
            return const SizedBox();
          }
        });
  }
}
