import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grasp_app/src/provider/theme_provider.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:provider/provider.dart';

class WidgetEndDrawerRecords extends StatelessWidget {
  WidgetEndDrawerRecords({
    Key? key,
    required this.enddrawerRecordId,
    required this.enddrawerRecordTitle,
    required this.enddrawerRecordRoutePath,
    required this.isSignOut,
    required this.theOnTap,
  }) : super(key: key);

  final int enddrawerRecordId;
  final String enddrawerRecordTitle;
  final String enddrawerRecordRoutePath;
  final bool isSignOut;
  final theOnTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // color: Colors.amber,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 0.0,
          margin: const EdgeInsets.only(bottom: 10.0, left: 6.0, right: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.grey.shade700.withOpacity(0.7)
                : Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0.0, 1.2), //(x,y)
                blurRadius: 02.0,
              ),
            ],
          ),
          child: ListTile(
              onTap: theOnTap,
              // () {
              //   debugPrint(isSignOut.toString());
              //   if (!isSignOut) {
              //     Get.toNamed(enddrawerRecordRoutePath);
              //   } else {
              //     firebaseAuth
              //         .signOut()
              //         .then((_) => Get.offAll(const ScreenSignin()));
              //   }
              // },
              // minVerticalPadding: 20,
              iconColor: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white70
                  : Colors.cyan.shade600,
              title: customeText(
                theData: enddrawerRecordTitle,
                theFontSize: 15,
                theMaxLines: 1,
              ),
              trailing: enddrawerRecordId == 1
                  ? Icon(FontAwesomeIcons.userLarge)
                  : enddrawerRecordId == 2
                      ? Icon(FontAwesomeIcons.solidStar)
                      : enddrawerRecordId == 3
                          ? Icon(FontAwesomeIcons.solidHeart)
                          : enddrawerRecordId == 4
                              ? Icon(Icons.label_important)
                              : enddrawerRecordId == 5
                                  ? Icon(Icons.archive)
                                  : enddrawerRecordId == 6
                                      ? Icon(FontAwesomeIcons.circleInfo)
                                      : enddrawerRecordId == 7
                                          ? Icon(Icons.logout)
                                          : Icon(Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkMode
                                              ? Icons.light_mode
                                              : Icons
                                                  .dark_mode_sharp) // when id >= 8
              //  _enddrawerRecordsWidgetDetector(
              //   _currentEnddrawerRecordIconDetector(),
              // ),
              ),
        ),
      ),
    );
  }
}
