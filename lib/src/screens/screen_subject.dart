import 'package:flutter/material.dart';
import 'package:grasp_app/src/data/datalist_subject.dart';
import 'package:grasp_app/src/methods/functions.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/widgets/end_drawer/end_drawer.dart';
import 'package:grasp_app/src/widgets/subject_records.dart';

class ScreenSubjects extends StatelessWidget {
  const ScreenSubjects({Key? key}) : super(key: key);

  final Color _enddrawerHeaderStuffLineColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.cyan.shade300,
                  Colors.grey.shade400,
                ],
              ),
            ),
            child: Column(
              children: [
                // end-drawer header
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // color: Colors.blue.shade300,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
                    ),
                  ),
                  // end-drawer all items in a row
                  child: Row(
                    children: [
                      // end-drawer (text + divider)
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            verticalDirection: VerticalDirection.down,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 2),
                                child: Text(
                                  'Barzy Yasin',
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _enddrawerHeaderStuffLineColor,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Divider(
                                color: _enddrawerHeaderStuffLineColor,
                                thickness: 1.9,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // end-drawer (image)
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: _enddrawerHeaderStuffLineColor, width: 2.5),
                          ),
                          alignment: Alignment.center,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/3.jpeg'),
                            radius: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.yellow,
                    padding: const EdgeInsets.only(
                        left: 15, top: 20, right: 35, bottom: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: const [
                            EndDrawer(enddrawerRecordId: 1, enddrawerRecordTitle: "My profile", enddrawerRecordRoutePath: RouteScreens.routeMyProfile ),
                            SizedBox(height: 18),
                            EndDrawer(enddrawerRecordId: 2, enddrawerRecordTitle: "Stars", enddrawerRecordRoutePath: RouteScreens.routeFilterStars ),
                            EndDrawer(enddrawerRecordId: 3, enddrawerRecordTitle: "Favorites", enddrawerRecordRoutePath: RouteScreens.routeFilterFavorites ),
                            EndDrawer(enddrawerRecordId: 4, enddrawerRecordTitle: "Importants", enddrawerRecordRoutePath: RouteScreens.routeFilterImportants ),
                            EndDrawer(enddrawerRecordId: 5, enddrawerRecordTitle: "Archived Grasps", enddrawerRecordRoutePath: RouteScreens.routeFilterArchived ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            EndDrawer(enddrawerRecordId: 6, enddrawerRecordTitle: "Grasp guidance", enddrawerRecordRoutePath: RouteScreens.routeGraspGuidance ),
                            EndDrawer(enddrawerRecordId: 7, enddrawerRecordTitle: "Exit", enddrawerRecordRoutePath: RouteScreens.routeInit ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        centerTitle: true,
        title: const Text('Subjects'),
        // actions: [
        //   Icon(Icons.add),
        //   Icon(Icons.add),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundGradientCyan(),
        child: ListView.builder(
          // clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          scrollDirection: Axis.vertical,
          itemCount: datalistSubject.length,
          itemBuilder: (context, theRecord) {
            return WidgetSubjectRecords(
              subjectRecordName:
                  datalistSubject[theRecord]["subject_name"].toString(),
              subjectRecordItemsNumber: int.parse(
                datalistSubject[theRecord]["subject_items_number"].toString(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan.shade700,
        elevation: 10,
        child: const Icon(
          Icons.create_new_folder,
          color: Colors.white,
          size: 29,
        ),
      ),
    );
  }
}
