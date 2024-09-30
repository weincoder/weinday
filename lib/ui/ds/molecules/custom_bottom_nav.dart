import 'package:flutter/material.dart';
import 'package:weinday/ui/helper/bottom_nav_tap.dart';
import 'package:weinds/tokens/colors.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: WeinDsColors.scale02,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: 'Diario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Acerca de',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: WeinDsColors.scale06,
        unselectedItemColor: WeinDsColors.scale03,
        onTap: (tab) {
          navigatorTap(tab, context);
        },);
  }
}
