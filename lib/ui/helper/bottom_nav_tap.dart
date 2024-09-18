import 'package:flutter/material.dart';

void navigatorTap(int tab, BuildContext context) {
  switch (tab) {
    case 0:
      Navigator.of(context).pushNamed('/diary');
      break;
    case 1:
      Navigator.of(context).pushNamed('/list-of-activities');
      break;
    case 2:
      Navigator.of(context).pushNamed('/about');
      break;
    default:
      Navigator.of(context).pushNamed('/');
      break;
  }
}
