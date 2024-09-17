import 'package:flutter/material.dart';
import 'package:weinday/db/diary_database.dart';
import 'package:weinday/ui/locale/labels.dart';
import 'package:weinds/tokens/colors.dart';

class ListOfActivities extends StatefulWidget {
  const ListOfActivities({super.key});

  @override
  State<ListOfActivities> createState() => _ListOfActivitiesState();
}

class _ListOfActivitiesState extends State<ListOfActivities> {
  final diaryDatabase = DiaryDatabase();
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
  DateTime? selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    userContainerDecoration = defaultContainerInputDecoration;
    pswContainerDecoration = defaultContainerInputDecoration;
  }

  @override
  Widget build(BuildContext context) {
    var date = selectedDate;
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
                    const Image(
                      image: AssetImage('assets/images/hiking.png'),
                    ),
                    Container(
                      height: 70,
                      width: 400,
                      padding: const EdgeInsets.only(left: 24, bottom: 4),
                      decoration: userContainerDecoration,
                      child: DropdownMenu<String>(
                          label: const Text(WeinDayCopys.registerActivityName,
                              style: TextStyle(
                                fontFamily: 'Cocogoose',
                                color: WeinDsColors.dark,
                                fontSize: 16.0,
                              )),
                          inputDecorationTheme: InputDecorationTheme(
                            labelStyle: defaultInputLabelTheme,
                            border: defaultInputBorder,
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
                    ),
                    const SizedBox(
                      height: 20,
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
                    ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        var pickedDate = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019),
                          lastDate: DateTime(2050),
                        );

                        setState(() {
                          selectedDate = pickedDate;
                        });
                      },
                      label: Text(selectedDate == null
                          ? WeinDayCopys.pickDate
                          : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 48),
                      width: 394,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formLoginKey.currentState!.validate()) {
                            if (_formLoginKey.currentState!.validate()) {
                              // Save data to database
                              await diaryDatabase.insertActivity(
                                selectedDate!.toIso8601String(),
                                dropdownValue,
                                actividad.text,
                              );

                              print('Activity saved to database!');

                              // Optionally clear form fields for new entry or navigate to another screen
                            }
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
