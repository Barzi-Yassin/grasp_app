import 'package:flutter/material.dart';
import 'package:grasp_app/src/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class widgetSwitchButtonChangeTheme extends StatelessWidget {
  const widgetSwitchButtonChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
