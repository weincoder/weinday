import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';
import 'package:weinds/tokens/colors.dart';
import 'package:weinds/weinds.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/fun.png'),
          ),
          const Text(
            'W E I N D A Y',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              color: WeinDsColors.dark,
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Una aplicación creada por Weincode',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              color: WeinDsColors.dark,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              launchUrl(
                Uri.parse('https://www.youtube.com/c/weincode'),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: WeinDsColors.scale06,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)))),
            child: const Text('Ir a canal de Youtube',
                style: TextStyle(
                  fontFamily: 'Cocogoose',
                  color: WeinDsColors.light,
                  fontSize: 16.0,
                )),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 2,
      ),
    );
  }
}
