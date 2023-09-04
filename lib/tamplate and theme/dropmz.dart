import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';

class DropMz extends StatelessWidget {
  DropMz(
      {super.key,
      required this.items,
      required this.title,
      this.onchange,
      required this.item});
  List<Map> items;
  Widget title;
  var onchange;
  String item;
  static bool openclosedrop = false;
  @override
  Widget build(BuildContext context) {
    Icon dropicon() => openclosedrop == false
        ? Icon(Icons.arrow_circle_down)
        : Icon(Icons.minimize);
    return GetBuilder<MainController>(
      init: mainController,
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () => mainController.openclosedropMz(),
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [title, dropicon()],
                    ),
                  ))),
          Visibility(
            visible: openclosedrop,
            child: Column(
              children: [
                ...items.map((e) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () => onchange(e), child: e[item])))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DropMz2 extends StatelessWidget {
  DropMz2({super.key, required this.items, this.onchange, required this.item});
  List<Map> items;
  var onchange;
  String item;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: mainController,
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Column(
              children: [
                ...items.map((e) => MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () => onchange(e), child: e[item])))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
