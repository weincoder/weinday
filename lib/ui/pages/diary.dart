import 'package:flutter/material.dart';
import 'package:weinday/ui/helper/validators.dart';
import 'package:weinday/ui/locale/labels.dart';
import 'package:weinds/tokens/colors.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  var checkBoxState = false;
  var actividad = TextEditingController();
  late String userName;
  double expectedTitlesize = 55;
  final _formLoginKey = GlobalKey<FormState>();
  late BoxDecoration userContainerDecoration;
  late BoxDecoration pswContainerDecoration;
  final defaultInputBorder = InputBorder.none;
  final defaultContainerInputDecoration = const BoxDecoration(
      color: WeinDsColors.scale02,
      borderRadius: BorderRadius.all(Radius.circular(4)));
  final activeContainerInputDecoration = BoxDecoration(
      color: WeinDsColors.scale02,
      border: Border.all(color: WeinDsColors.light, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(4)));
  final defaultInputLabelTheme = const TextStyle(
      fontSize: 13, color: WeinDsColors.scale02, fontWeight: FontWeight.normal);
  @override
  void initState() {
    super.initState();
    userContainerDecoration = defaultContainerInputDecoration;
    pswContainerDecoration = defaultContainerInputDecoration;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = WeinDayCopys.listOFActivities.first;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Center(
            child: Form(
                key: _formLoginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu<String>(
                        menuStyle: MenuStyle(
                          backgroundColor:
                              WidgetStateProperty.all(WeinDsColors.scale02),
                          minimumSize:
                              WidgetStateProperty.all(const Size(500, 500)),
                        ),
                        initialSelection: WeinDayCopys.listOFActivities.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: WeinDayCopys.listOFActivities
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList()),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.only(left: 24, bottom: 4),
                      decoration: userContainerDecoration,
                      child: TextFormField(
                          key: const Key('input-name'),
                          controller: actividad,
                          style: const TextStyle(
                            fontFamily: 'Cocogoose',
                            color: WeinDsColors.dark,
                            fontSize: 16.0,
                          ),
                          validator: (value) => validateInput(value),
                          onTap: () {
                            setState(() {
                              userContainerDecoration =
                                  activeContainerInputDecoration;
                              pswContainerDecoration =
                                  defaultContainerInputDecoration;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              userContainerDecoration =
                                  defaultContainerInputDecoration;
                            });
                          },
                          onSaved: (userNameValue) {
                            userName = userNameValue!;
                          },
                          decoration: InputDecoration(
                              border: defaultInputBorder,
                              label: Text(WeinDayCopys.registerActivityName,
                                  style: TextStyle(
                                    fontFamily: 'Cocogoose',
                                    color: WeinDsColors.dark,
                                    fontSize: 16.0,
                                  )))),
                    ),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.only(left: 24, bottom: 4),
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      decoration: pswContainerDecoration,
                      child: TextFormField(
                          style: const TextStyle(
                            fontFamily: 'Cocogoose',
                            color: WeinDsColors.dark,
                            fontSize: 16.0,
                          ),
                          key: const Key('input-psw'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return WeinDayErrors
                                  .descriptionActivityErrorLabel;
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              pswContainerDecoration =
                                  activeContainerInputDecoration;
                              userContainerDecoration =
                                  defaultContainerInputDecoration;
                            });
                          },
                          onTapOutside: (event) {
                            setState(() {
                              pswContainerDecoration =
                                  defaultContainerInputDecoration;
                            });
                          },
                          obscureText: false,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                              border: defaultInputBorder,
                              label: const Text(WeinDayCopys.descriptionLabel),
                              labelStyle: TextStyle(
                                fontFamily: 'Cocogoose',
                                color: WeinDsColors.dark,
                                fontSize: 16.0,
                              ))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 48),
                      width: 394,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formLoginKey.currentState!.validate()) {
                            print('Todos lo campos estan ok 🤯');
                            // _formLoginKey.currentState!.save();
                            userName = actividad.text;
                            // UserProvider.of(context).userData.name = userName;
                            // Navigator.of(context)
                            //     .pushReplacementNamed(AppRoutes.home);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: WeinDsColors.scale06,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
                        child: const Text(WeinDayCopys.submitActivityLabel,
                            style: TextStyle(
                              fontFamily: 'Cocogoose',
                              color: WeinDsColors.light,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    // const DividerWithText(title: WeinfluCopys.orContinue),
                    const SizedBox(
                      height: 42,
                    ),
                  ],
                ))),
      ),
    );
  }
}
