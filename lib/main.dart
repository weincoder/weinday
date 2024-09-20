import 'package:flutter/material.dart';
import 'package:weinday/ui/pages/about.dart';
import 'package:weinday/ui/pages/diary.dart';
import 'package:weinday/ui/pages/home_wein_day.dart';
import 'package:weinday/ui/pages/list_activities.dart';
import 'package:weinds/foundations/themes/weinds_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/diary': (context) => const Diary(),
        '/': (context) => const HomeWeinDay(),
        '/list-of-activities': (context) => const ListOfActivities(),
        '/about': (context) => const About(),
      },
      theme: ligthThemeWeincode,
    );
  }
}
