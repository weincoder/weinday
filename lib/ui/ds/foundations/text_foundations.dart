import 'package:flutter/material.dart';
import 'package:weinds/tokens/colors.dart';

//TODO: Cambiar a fuente free que use numeros
class TextFoundations {
  static const TextStyle styleLeading = TextStyle(
    fontFamily: 'Cocogoose',
    color: WeinDsColors.light,
    fontSize: 12.0,
  );

  static const TextStyle styleTitle = TextStyle(
    fontFamily: 'Cocogoose',
    color: WeinDsColors.scale01,
    fontSize: 16.0,
  );
  static const TextStyle dropDownTextStyle = TextStyle(
    fontFamily: 'Cocogoose',
    color: WeinDsColors.scale01,
    fontSize: 16.0,
  );

  static const TextStyle inputTextStyle = TextStyle(
    // fontFamily: 'Cocogoose', 3
    color: WeinDsColors.scale05,
    fontSize: 16.0,
  );
  static const TextStyle inputLabelStyle = TextStyle(
    fontFamily: 'Cocogoose',
    color: WeinDsColors.dark,
    fontSize: 12.0,
  );

  static const TextStyle styleTrailing = TextStyle(
    color: WeinDsColors.light,
    fontSize: 12.0,
  );

  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Cocogoose',
    color: WeinDsColors.dark,
    fontSize: 27.0,
  );
}
