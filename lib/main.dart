import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicare/constants/constants.dart';
import 'package:medicare/screens/home.dart';
import 'package:medicare/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';

import 'localizations/localconstants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: AppConstant.SUPPORTED_LOCALE,
      path: AppConstant.LANG_PATH,
      fallbackLocale: Locale('tr', 'TR'),
      child: const MyApp()));
}

ThemeMode _themeMode = ThemeMode.light;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Medicare Sağlik Takip',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(),
          brightness: Brightness.light,
          primaryColorLight: Constants().primaryColor,
          scaffoldBackgroundColor: Constants().scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: Constants().appBarColor),
        ),
        darkTheme: ThemeData(
          primaryColorDark: Constants().primaryColor,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Constants().appBarColorDark),
          primaryColor: Constants().appBarColor,

          /* dark theme settings */
        ),
        themeMode: _themeMode,

        /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
     */
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Splash());
  }
}
