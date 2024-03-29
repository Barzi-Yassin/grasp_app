import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grasp_app/src/provider/theme_provider.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:grasp_app/src/reusable_codes/functions/loadings/loading_indicator.dart';
import 'package:grasp_app/src/routes/route_screens.dart';
import 'package:grasp_app/src/reusable_codes/widgets/end_drawer/widget_end_drawer_records.dart';
import 'package:grasp_app/src/screens/auth/screen_signin.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_favorites.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_filter_stars.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_grasp_guidance.dart';
import 'package:grasp_app/src/screens/screens_from_enddrawer/screen_my_profile.dart';
import 'package:grasp_app/src/services/firebase/service_firestore.dart';
import 'package:provider/provider.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({Key? key, this.theUser}) : super(key: key);
  final User? theUser;

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ServiceFirestore serviceFirestore = ServiceFirestore();

  final Color _enddrawerHeaderStuffLineColor = Colors.white;

  // bool themeGenerator = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);

    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          border: Border.all(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.black
                  : Colors.cyan),
          // border: const Border(
          //   top: BorderSide.none,
          //   bottom: BorderSide.none,
          //   right: BorderSide.none,
          //   left: BorderSide(
          //       color: Colors.cyan, width: 1.5, style: BorderStyle.solid),
          // ),

          // body gradient color
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: Provider.of<ThemeProvider>(context).isDarkMode
                ? [
                    Colors.grey.shade800,
                    Colors.grey.shade800,
                  ]
                : [
                    Colors.cyan.shade300,
                    Colors.grey.shade400,
                  ],
          ),
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: serviceFirestore.firestoreInstance
                .collection("users")
                .doc(widget.theUser!.uid)
                .snapshots(),
            builder: (context, snapshotProfile) {
              if (snapshotProfile.connectionState == ConnectionState.waiting) {
                return loadingIndicator();
              } else if (snapshotProfile.hasError) {
                return customeText(theData: "err ${snapshotProfile.error}");
              } else if (snapshotProfile.data == null ||
                  !snapshotProfile.hasData) {
                return customeText(
                    theData: 'snapshotFiles is empty(StreamBuilder)');
              }

              final snapshotProfileUsername = snapshotProfile.data!.get("name");
              final snapshotProfileImgUrl =
                  snapshotProfile.data!.get("imageUrl");

              // debugPrint('00000 :: ${snapshotProfile.data}');
              // debugPrint('00000 :: $snapshotProfileUsername');
              // debugPrint('00000 :: $snapshotProfileImgUrl');
              return Column(
                children: [
                  // end-drawer headerl
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 0),
                    decoration: BoxDecoration(
                      // color: Colors.grey.shade300,
                      // color: ThemeGenerator
                      //         .getthemeCurrentDarkTrueLightFalse // TODO: temporary theme
                      //     ? Colors.grey.shade600
                      //     : Colors.cyan.shade600,

                      // header color decoration (appbarr)
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.black54
                          // ? Colors.black38
                          : Colors.cyan.shade600,
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
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              Get.to(
                                () => ScreenMyProfile(
                                  theUser: widget.theUser,
                                  theImgUrl: snapshotProfileImgUrl,
                                  theUsername: snapshotProfileUsername,
                                ),
                              );
                            },
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
                                          child: customeText(
                                            theData:
                                                snapshotProfileUsername, // here
                                            theTextAlign: TextAlign.left,
                                            theMaxLines: 1,
                                            theFontSize: 20,
                                            theColor:
                                                _enddrawerHeaderStuffLineColor,
                                            theFontWeight: FontWeight.w500,
                                            theLetterSpacing: 0.5,
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
                                        width: 2.0,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: snapshotProfileImgUrl.length > 20
                                        ? Container(
                                            width: 48,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5200),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshotProfileImgUrl
                                                    .toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.transparent,
                                                        BlendMode.colorBurn,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    loadingIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                ),
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 26,
                                            backgroundImage: const AssetImage(
                                              'assets/images/default.jpg',
                                            ), // here
                                          ),
                                  ),
                                ),
                              ],
                            ),
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
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeMyProfile,
                                theOnTap: () {
                                  Get.back();
                                  return Get.to(
                                    () => ScreenMyProfile(
                                      theUser: widget.theUser,
                                      theImgUrl: snapshotProfileImgUrl,
                                      theUsername: snapshotProfileUsername,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 18),
                              WidgetEndDrawerRecords(
                                enddrawerRecordId: 2,
                                enddrawerRecordTitle: "Stars",
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeFilterStars,
                                theOnTap: () {
                                  Get.back();
                                  return Get.to(
                                    () => ScreenFilterStars(
                                      theUser: widget.theUser,
                                    ),
                                  );
                                },
                              ),
                              WidgetEndDrawerRecords(
                                enddrawerRecordId: 3,
                                enddrawerRecordTitle: "Favorites",
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeFilterFavorites,
                                theOnTap: () {
                                  Get.back();
                                  return Get.to(
                                    ScreenFilterFavorites(
                                      theUser: widget.theUser,
                                    ),
                                  );
                                },
                              ),
                              //     enddrawerRecordId: 4,
                              //     enddrawerRecordTitle: "Importants",
                              // WidgetEndDrawerRecords(
                              //     enddrawerRecordRoutePath:
                              // WidgetEndDrawerRecords(
                              //     enddrawerRecordId: 5,
                              //     enddrawerRecordTitle: "Archived Grasps",
                              //     enddrawerRecordRoutePath:
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetEndDrawerRecords(
                                enddrawerRecordId: 8,
                                enddrawerRecordTitle: provider.isDarkMode
                                    ? "Light Mode"
                                    : "Dark Mode",
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeGraspGuidance,
                                theOnTap: () {
                                  provider.toggleTheme(provider.isDarkMode);
                                  Get.back();  //  uncomment here
                                },
                              ),
                              WidgetEndDrawerRecords(
                                enddrawerRecordId: 6,
                                enddrawerRecordTitle: "Grasp Guidance",
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeGraspGuidance,
                                theOnTap: () {
                                  Get.back();
                                  return Get.to(
                                    () => ScreenGraspGuidance(
                                      theUser: widget.theUser,
                                    ),
                                  );
                                },
                              ),
                              WidgetEndDrawerRecords(
                                enddrawerRecordId: 7,
                                enddrawerRecordTitle: "Logout",
                                enddrawerRecordRoutePath:
                                    RouteScreens.routeInit,
                                theOnTap: () =>
                                    Get.offAll(() => const ScreenSignin()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
