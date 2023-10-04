import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/screens/splash_screen/splash_screen.dart';


void main() {
  runApp(ChangeNotifierProvider(create: (context)=>SettingsProvider(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var settingsProvider= Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) =>  HomeScreen(),
        SplashScreen.routeName : (_)=> SplashScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingsProvider.currentTheme,
      locale: Locale(settingsProvider.currentLocale),

    );
  }
}
