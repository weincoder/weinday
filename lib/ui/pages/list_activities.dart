import 'package:flutter/material.dart';
import 'package:weinday/db/diary_database.dart';
import 'package:weinday/ui/ds/animations/animations.dart';
import 'package:weinday/ui/ds/foundations/text_foundations.dart';
import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';
import 'package:weinday/ui/helper/bottom_nav_tap.dart';
import 'package:weinday/ui/locale/labels.dart';
import 'package:weinday/ui/pages/diary.dart';
import 'package:weinds/tokens/colors.dart';

class ListOfActivities extends StatefulWidget {
  const ListOfActivities({super.key});

  @override
  State<ListOfActivities> createState() => _ListOfActivitiesState();
}

class _ListOfActivitiesState extends State<ListOfActivities> {
  final diaryDatabase = DiaryDatabase();

  @override
  Widget build(BuildContext context) {
    final diaryDatabase = DiaryDatabase();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Histórico de tus actividades',
                style: TextFoundations.headingStyle,
              ),
              const Image(image: AssetImage(WeinDayMapImages.reading)),
              Expanded(
                child: FutureBuilder(
                    future: diaryDatabase.getAllDiary(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: WeinDsColors.scale05,
                              leading: Text(
                                snapshot.data![index]['activity'],
                                style: TextFoundations.styleLeading,
                              ),
                              title: Text(
                                snapshot.data![index]['description'] ??
                                    'No diste descripcion',
                                style: TextFoundations.styleTitle,
                              ),
                              trailing: Text(snapshot.data![index]['date'],
                                  style: TextFoundations.styleTrailing),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 18,
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/images/travel.png'),
                              ),
                              const Text('Aun no has agregado acitividades'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      getAnimatedRightToLeftRoute(
                                          const Diary()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: WeinDsColors.scale06,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)))),
                                child: const Text('Ingresar actividades',
                                    style: TextStyle(
                                      fontFamily: 'Cocogoose',
                                      color: WeinDsColors.light,
                                      fontSize: 16.0,
                                    )),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNav(
          currentIndex: 1,
        ));
  }
}
