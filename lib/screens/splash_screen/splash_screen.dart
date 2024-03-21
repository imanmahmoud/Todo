import 'dart:async';

import 'package:flutter/material.dart';
/*import 'package:provider/provider.dart';*/
import 'package:todo/screens/home/home_screen.dart';

/*import '../../providers/settings_provider.dart';*/

class SplashScreen extends StatelessWidget {
  static const routeName="splash screen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),() {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    },);

    /*var settingsProvider= Provider.of<SettingsProvider>(context);*/
    return Scaffold(
      body: Image.asset(/*settingsProvider.isDark()?'assets/images/splash_background_dark.png':*/'assets/images/splash_background.png',
          width: double.infinity,height: double.infinity,fit:BoxFit.fill)

    ) ;
  }
}
