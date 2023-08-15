// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFieldMZ extends StatelessWidget {
  TextFieldMZ(
      {super.key,
      this.controller,
      required this.label,
      this.readOnly = false,
      required this.onchange,
      this.errormsg,
      this.obscureText = false,
      this.textAlign = TextAlign.center,
      this.textDirection = TextDirection.rtl,
      this.icon,
      required this.action,
      required this.ontap});
  TextEditingController? controller = TextEditingController();
  String label;
  String? errormsg;
  bool readOnly, obscureText;
  Function onchange, ontap, action;
  TextAlign textAlign;
  TextDirection textDirection;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width > 500
              ? 500
              : MediaQuery.of(context).size.width,
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            obscureText: obscureText,
            textAlign: textAlign,
            onChanged: (x) => onchange(x),
            onTap: () => ontap(),
            decoration: InputDecoration(
                suffixIcon:
                    IconButton(onPressed: () => action(), icon: Icon(icon)),
                label: Text(label),
                errorText: errormsg,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ),
      ),
    );
  }
}
