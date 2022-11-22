import 'package:flutter/material.dart';
import 'package:grasp_app/src/provider/theme_provider.dart';
import 'package:grasp_app/src/reusable_codes/functions/functions.dart';
import 'package:provider/provider.dart';

class DialogMainBoilerplate extends StatefulWidget {
  DialogMainBoilerplate({
    super.key,
    required this.theTitle,
    required this.theWidgetContent,
    required this.theIsButtonElevatedWithIcon,
    required this.theOnPressed,
    required this.theButtonLabel,
    this.theButtonIcon,
  });

  final String theTitle;
  final Widget theWidgetContent;
  final bool theIsButtonElevatedWithIcon;
  final String theButtonLabel;
  final IconData? theButtonIcon;
  final theOnPressed; // TODO: fix it's error

  @override
  State<DialogMainBoilerplate> createState() => _DialogMainBoilerplateState();
}

class _DialogMainBoilerplateState extends State<DialogMainBoilerplate> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      insetPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      // titlePadding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      elevation: 5,
      actionsOverflowButtonSpacing: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          // border color
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.black
              : Colors.cyan,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      // background color
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? Colors.grey.shade800
          : Colors.white,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 15.0),
        decoration: BoxDecoration(
          gradient: dialogHeaderGradient(context),
          borderRadius: BorderRadius.circular(15),
        ), //

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Divider(
                thickness: 1,
                endIndent: 10,
              ),
            ),
            customeText(
              theData: widget.theTitle,
              theColor: Provider.of<ThemeProvider>(context).isDarkMode
                  ? Colors.white54
                  : Color.fromARGB(255, 126, 50, 50),
            ),
            const Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
      ),
      content: widget.theWidgetContent,
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              // buttons color
              backgroundColor: MaterialStateProperty.all(
                Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.white24
                    : Colors.white,
              ),
              side: MaterialStateProperty.all(BorderSide(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.black
                      : Colors.cyan))),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: customeText(
            theData: "Cancle",
            theColor: Provider.of<ThemeProvider>(context).isDarkMode
                ? Colors.black
                : Colors.cyan,
          ),
        ),
        widget.theIsButtonElevatedWithIcon
            ? ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? Colors.black26
                          : Colors.cyan),
                ),
                onPressed: widget.theOnPressed,
                icon: customeIcon(
                    theIcon: Icons.delete_forever_outlined,
                    theColor: Provider.of<ThemeProvider>(context).isDarkMode
                        ? Colors.white54
                        : Colors.white),
                label: customeText(
                  theData: widget.theButtonLabel,
                  theColor: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white54
                      : Colors.white,
                ),
              )
            : ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.black26
                      : Colors.cyan,
                )),
                onPressed: widget.theOnPressed,
                child: customeText(
                  theData: widget.theButtonLabel,
                  theColor: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white54
                      : Colors.white,
                ),
              )
      ],
    );
  }
}
