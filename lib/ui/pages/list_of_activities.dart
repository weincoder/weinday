import 'package:flutter/material.dart';
import 'package:weinday/db/diary_database.dart';
import 'package:weinday/ui/ds/animations/animations.dart';
import 'package:weinday/ui/ds/foundations/text_foundations.dart';
import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';
import 'package:weinday/ui/locale/weinday_copys.dart';
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
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            backgroundColor: WeinDsColors.light,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(36.0),
                child: Image(
                  image: AssetImage(WeinDayMapImages.reading),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            automaticallyImplyLeading:
                false, // Add this line to hide the back button icon
          ),
          SliverPadding(
            padding: const EdgeInsets.all(27.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Text(
                    'Histórico de tus actividades',
                    style: TextFoundations.headingStyle,
                  ),
                  FutureBuilder(
                    future: diaryDatabase.getAllDiary(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final activities =
                            snapshot.data as List<Map<String, dynamic>>;
                        final groupedActivities =
                            groupActivitiesByDate(activities);
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: groupedActivities.length,
                                itemBuilder: (context, index) {
                                  final date =
                                      groupedActivities.keys.elementAt(index);
                                  final activitiesForDate =
                                      groupedActivities[date];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          date,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      if (activitiesForDate == null ||
                                          activitiesForDate.isEmpty)
                                        const SizedBox()
                                      else
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: activitiesForDate.length,
                                          itemBuilder: (context, index) {
                                            final activity =
                                                activitiesForDate[index];
                                            return ListTile(
                                              tileColor: WeinDsColors.scale05,
                                              leading: Text(
                                                activity['activity'],
                                                style: TextFoundations
                                                    .styleLeading,
                                              ),
                                              title: Text(
                                                activity['description'] ??
                                                    'No diste descripcion',
                                                style:
                                                    TextFoundations.styleTitle,
                                              ),
                                              trailing: Text(
                                                activity['date'],
                                                style: TextFoundations
                                                    .styleTrailing,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 18,
                                            );
                                          },
                                        ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        );
                      }
                      return snapshot.hasError
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/images/travel.png',
                                    ),
                                  ),
                                  const Text(
                                    'Aun no has agregado acitividades',
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        getAnimatedRightToLeftRoute(
                                          const Diary(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: WeinDsColors.scale06,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Ingresar actividades',
                                      style: TextStyle(
                                        fontFamily: 'Cocogoose',
                                        color: WeinDsColors.light,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(
        currentIndex: 1,
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> groupActivitiesByDate(
    List<Map<String, dynamic>> activities,
  ) {
    final groupedActivities = <String, List<Map<String, dynamic>>>{};
    for (final activity in activities) {
      final date = activity['date'] as String;
      if (groupedActivities.containsKey(date)) {
        groupedActivities[date]!.add(activity);
      } else {
        groupedActivities[date] = [activity];
      }
    }
    return groupedActivities;
  }
}
