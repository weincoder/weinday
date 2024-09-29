import 'package:flutter/material.dart';
import 'package:weinday/db/diary_database.dart';
import 'package:weinday/ui/ds/foundations/text_foundations.dart';
import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';
import 'package:weinday/ui/locale/labels.dart';
import 'package:weinds/tokens/colors.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  final diaryDatabase = DiaryDatabase();
  var checkBoxState = false;
  String dropdownValue = WeinDayCopys.listOFActivities.first;
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(27.0),
              child: Form(
                  key: _formLoginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Reporte de tus actividades',
                        style: TextFoundations.headingStyle,
                      ),
                      const Image(
                        image: AssetImage('assets/images/hiking.png'),
                      ),
                      Container(
                        height: 70,
                        width: 400,
                        padding: const EdgeInsets.only(
                            left: 12, bottom: 4, right: 30, top: 8),
                        decoration: userContainerDecoration,
                        child: DropdownMenu<String>(
                            width: 300,
                            label: const Text(WeinDayCopys.registerActivityName,
                                style: TextFoundations.inputLabelStyle),
                            inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextFoundations.styleLeading,
                              border: defaultInputBorder,
                            ),
                            initialSelection:
                                WeinDayCopys.listOFActivities.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            menuStyle: MenuStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(WeinDsColors.scale06),
                              surfaceTintColor:
                                  WidgetStateProperty.all(WeinDsColors.scale00),
                              shadowColor:
                                  WidgetStateProperty.all(WeinDsColors.scale05),
                              elevation: WidgetStateProperty.all(4),
                            ),
                            textStyle: TextFoundations.inputTextStyle,
                            dropdownMenuEntries: WeinDayCopys.listOFActivities
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                                labelWidget: Text(
                                  value,
                                  style: TextFoundations.dropDownTextStyle,
                                ),
                              );
                            }).toList()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        padding:
                            const EdgeInsets.only(left: 24, bottom: 4, top: 8),
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        decoration: pswContainerDecoration,
                        child: TextFormField(
                            controller: actividad,
                            style: TextFoundations.inputTextStyle,
                            key: const Key('input-psw'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return WeinDayErrors
                                    .descriptionActivityErrorLabel;
                              }
                              return null;
                            },
                            onTap: () {},
                            obscureText: false,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                                border: defaultInputBorder,
                                label:
                                    const Text(WeinDayCopys.descriptionLabel),
                                labelStyle: TextFoundations.inputLabelStyle)),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: WeinDsColors.scale06,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: WeinDsColors.scale02,
                            // onPrimary: WeinDsColors.light,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
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
                        label: Text(
                            selectedDate == null
                                ? WeinDayCopys.pickDate
                                : '${date?.month}/${date?.day}/${date?.year}',
                            style: TextFoundations.inputTextStyle),
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
                                String currentSelectedDate =
                                    '${date?.month}/${date?.day}/${date?.year}';
                                await diaryDatabase.insertActivity(
                                  currentSelectedDate,
                                  dropdownValue,
                                  actividad.text,
                                );
                                Navigator.of(context)
                                    .pushNamed('/list-of-activities');
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
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 0,
      ),
    );
  }
}
