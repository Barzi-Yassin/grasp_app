import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer_records.dart';

class EndDrawer extends StatelessWidget {
  EndDrawer({Key? key}) : super(key: key);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final Color _enddrawerHeaderStuffLineColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          border: Border.all(color: Colors.cyan),
          // border: const Border(
          //   top: BorderSide.none,
          //   bottom: BorderSide.none,
          //   right: BorderSide.none,
          //   left: BorderSide(
          //       color: Colors.cyan, width: 1.5, style: BorderStyle.solid),
          // ),
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
              padding: const EdgeInsets.only(left: 20, top: 8, bottom: 0),
              decoration: BoxDecoration(
                // color: Colors.grey.shade300,
                color: Colors.cyan.shade600,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              // end-drawer all items in a row
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    margin: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        // end-drawer (text)
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
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 18),
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
                                // Divider(
                                //   color: _enddrawerHeaderStuffLineColor,
                                //   thickness: 1.9,
                                // ),
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
                              border: Border.all(
                                  color: _enddrawerHeaderStuffLineColor,
                                  width: 2.0),
                            ),
                            alignment: Alignment.center,
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/3.jpeg'),
                              radius: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 17,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 0.0),
                          child: const Divider(
                            color: Colors.white,
                            height: 0,
                            thickness: 2.0,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 3,
                        child: Divider(
                          color: Colors.transparent,
                          height: 0,
                          thickness: 2.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        WidgetEndDrawerRecords(
                          enddrawerRecordId: 1,
                          enddrawerRecordTitle: "My profile",
                          enddrawerRecordRoutePath: RouteScreens.routeMyProfile,
                          isSignOut: false,
                        ),
                        const SizedBox(height: 18),
                        WidgetEndDrawerRecords(
                          enddrawerRecordId: 2,
                          enddrawerRecordTitle: "Stars",
                          enddrawerRecordRoutePath:
                              RouteScreens.routeFilterStars,
                          isSignOut: false,
                        ),
                        WidgetEndDrawerRecords(
                          enddrawerRecordId: 3,
                          enddrawerRecordTitle: "Favorites",
                          enddrawerRecordRoutePath:
                              RouteScreens.routeFilterFavorites,
                          isSignOut: false,
                        ),
                        // WidgetEndDrawerRecords(
                        //     enddrawerRecordId: 4,
                        //     enddrawerRecordTitle: "Importants",
                        //     enddrawerRecordRoutePath:
                        //         RouteScreens.routeFilterImportants, isSignOut: false,),
                        // WidgetEndDrawerRecords(
                        //     enddrawerRecordId: 5,
                        //     enddrawerRecordTitle: "Archived Grasps",
                        //     enddrawerRecordRoutePath:
                        //         RouteScreens.routeFilterArchived, isSignOut: false,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetEndDrawerRecords(
                          enddrawerRecordId: 6,
                          enddrawerRecordTitle: "Grasp guidance",
                          enddrawerRecordRoutePath:
                              RouteScreens.routeGraspGuidance,
                          isSignOut: false,
                        ),
                        WidgetEndDrawerRecords(
                          enddrawerRecordId: 7,
                          enddrawerRecordTitle: "Logout",
                          enddrawerRecordRoutePath: RouteScreens.routeInit,
                          isSignOut: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
