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

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final IconData iconProfile = FontAwesomeIcons.userLarge;
  final IconData iconStars = FontAwesomeIcons.solidStar;
  final IconData iconFavorites = FontAwesomeIcons.solidHeart;
  final IconData iconImportants = Icons.label_important;
  final IconData iconArchivedGrasps = Icons.archive;
  final IconData iconGraspGuidance = FontAwesomeIcons.circleInfo;
  final IconData iconLogout = Icons.logout;
  final IconData iconSettings = Icons.settings;
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
            trailing: _enddrawerRecordsWidgetDetector(
              _currentEnddrawerRecordIconDetector(),
            ),
          ),
        ),
      ),
    );
  }

// this function returns a widgets "Icon() or FaIcon()"
  Widget _enddrawerRecordsWidgetDetector(IconData iconName) {
    if (enddrawerRecordId <= 3 || enddrawerRecordId >= 6) {
      return Icon(iconName);
    } else {
      return FaIcon(iconName);
    }
  }

  IconData _currentEnddrawerRecordIconDetector() {
    if (enddrawerRecordId == 1) {
      return iconProfile;
    } else if (enddrawerRecordId == 2) {
      return iconStars;
    } else if (enddrawerRecordId == 3) {
      return iconFavorites;
    } else if (enddrawerRecordId == 4) {
      return iconImportants;
    } else if (enddrawerRecordId == 5) {
      return iconArchivedGrasps;
    } else if (enddrawerRecordId == 6) {
      return iconGraspGuidance;
    } else if (enddrawerRecordId == 7) {
      return iconLogout;
    } else {
      return iconSettings;
    }
  }
}
