import 'package:flutter/material.dart';

Widget buildTextContainer(double margin, double padding, Widget widget) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: margin * 0.5),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: widget);
}
