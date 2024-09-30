import 'package:flutter/material.dart';
import 'package:weinday/ui/ds/animations/animations.dart';
import 'package:weinday/ui/pages/diary.dart';
import 'package:weinds/tokens/colors.dart';
import 'package:weinds/weinds.dart';

class HomeWeinDay extends StatelessWidget {
  const HomeWeinDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/read.png'),
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
            'Tu aliado en conocerte mejor',
            style: TextStyle(
              fontFamily: 'Cocogoose',
              color: WeinDsColors.dark,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                getAnimatedRightToLeftRoute(const Diary()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: WeinDsColors.scale06,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),),),
            child: const Text('Iniciar',
                style: TextStyle(
                  fontFamily: 'Cocogoose',
                  color: WeinDsColors.light,
                  fontSize: 16.0,
                ),),
          ),
        ],
      ),
    );
  }
}
