import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dialogmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static IconData modeicon = Icons.sunny;
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    ThemeController themeController = Get.find();
    List draweritems() => [
          {
            'title':
                "${Lang.lang['drawerpersonalinfo'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'action': () => DialogMz.chgpassshowpersonalDialog(ctx: context),
            'icon': Icons.person,
          },
          {
            'title':
                "${Lang.lang['drawerpesonalchgpass'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'action': () => DialogMz.chgpassfrompresonalDialog(ctx: context),
            'icon': Icons.password
          },
          {
            'title':
                "${Lang.lang['logout'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.logout,
            'action': () async => await mainController.logout()
          },
        ];
    List appbaritems() => [
          {'icon': Icons.notifications, 'action': () {}},
          {
            'icon': modeicon,
            'action': () async => await themeController.changetheme()
          },
        ];
    List maindepartments() => [
          {
            'visible': DB.userinfotable[0]['admin'] == '1' ? true : false,
            'title':
                "${Lang.lang['offices'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.work,
            'action': () {},
          },
          {
            'visible': DB.userinfotable[0]['admin'] == '1' ? true : false,
            'title':
                "${Lang.lang['accounts'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.people,
            'action': () {},
          },
          {
            'visible':
                DB.userinfotable[0]['office_priv'].isNotEmpty ? true : false,
            'title':
                "${Lang.lang['tasks'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.task,
            'action': () {},
          },
          {
            'visible':
                DB.userinfotable[0]['office_priv'].isNotEmpty ? true : false,
            'title':
                "${Lang.lang['todo'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.question_mark,
            'action': () {},
          },
          {
            'visible':
                DB.userinfotable[0]['office_priv'].isNotEmpty ? true : false,
            'title':
                "${Lang.lang['remind'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.alarm,
            'action': () {},
          },
          {
            'visible':
                DB.userinfotable[0]['office_priv'].isNotEmpty ? true : false,
            'title':
                "${Lang.lang['ping'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.wifi,
            'action': () {},
          },
          {
            'visible':
                DB.userinfotable[0]['office_priv'].isNotEmpty ? true : false,
            'title':
                "${Lang.lang['checkemails'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.attach_email,
            'action': () {},
          },
          {
            'visible': DB.userinfotable[0]['pbx'] == '1' ? true : false,
            'title':
                "${Lang.lang['pbx'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.phone,
            'action': () {},
          },
          {
            'title':
                "${Lang.lang['hlinks'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Icons.link,
            'action': () {},
          }
        ];
    return FutureBuilder(future: Future(() async {
      ThemeMz.mode = SharedPreMz.sharedPreMzGetMode() ?? 'light';
    }), builder: (_, snap) {
      if (LogIn.userinfo != null) {
        return GetBuilder<ThemeController>(
          init: themeController,
          builder: (_) => SafeArea(
              child: Directionality(
            textDirection: InfoBasic.textDirection(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "${Lang.lang['homepageapptitle'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                actions: [
                  ...appbaritems().map((e) =>
                      IconButton(onPressed: e['action'], icon: Icon(e['icon'])))
                ],
              ),
              drawer: Drawer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...draweritems().map((e) => TweenMz.translatex(
                        durationinmilliseconds: 300,
                        begin: -200.0,
                        end: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton.icon(
                                  onPressed: e['action'],
                                  icon: Icon(e['icon']),
                                  label: Text(
                                    e['title'],
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )),
                            ),
                            const Divider()
                          ],
                        ),
                      )),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text(
                          "${Lang.lang['choselang'][Lang.langlist.indexOf(Lang.selectlanguage)]}"),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: themeController.chooselang())
                    ]),
                  ),
                ],
              )),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: maindepartments().length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: AppBar().preferredSize.height,
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width / 2),
                          itemBuilder: (_, x) {
                            return TweenMz.opacitiy(
                                begin: 0.0,
                                end: 1.0,
                                durationinmilliseconds: (x + 2) * 300,
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Card(
                                        elevation: 6,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.elliptical(20, 10)),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      maindepartments()[x]
                                                          ['icon'],
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    "${maindepartments()[x]['title']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ))
                                                ])))));
                          }),
                    ),
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              bottomNavigationBar: BottomNavBarMz(),
            ),
          )),
        );
      } else {
        Future(() => Get.offAllNamed('/login'));
        return const SizedBox();
      }
    });
  }
}
