import 'package:bsadosecalculator/constants.dart';
import 'package:bsadosecalculator/my_flutter_app_icons.dart';
import 'package:bsadosecalculator/ui/home.dart';
import 'package:bsadosecalculator/my_keyboard_actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppRoot extends StatefulWidget {
  AppRoot({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return buildPlatformApp(context);
  }
}

Widget buildPlatformApp(BuildContext context) {
  List<dynamic> sharedPlatformData = getSharedPlatformData(context);

  switch (platform) {
    case Platforms.android:
      return MaterialApp(
        home: appHome(),
        debugShowCheckedModeBanner: sharedPlatformData[0],
        //initialRoute: sharedPlatformData[1],
        //routes: sharedPlatformData[2],
        theme: sharedPlatformData[1],
        localizationsDelegates: sharedPlatformData[2],
        supportedLocales: sharedPlatformData[3],
      );

      break;
    case Platforms.ios:
      return CupertinoApp(
        home: appHome(),
        debugShowCheckedModeBanner: sharedPlatformData[0],
        //initialRoute: sharedPlatformData[1],
        //routes: sharedPlatformData[2],
        theme: sharedPlatformData[1],
        localizationsDelegates: sharedPlatformData[2],
        supportedLocales: sharedPlatformData[3],
      );

      break;
  }

  return null;
}

List<dynamic> getSharedPlatformData(BuildContext context) {
  //const LocalizationsDelegate<dynamic> appLocalizationsDelegate = AppLocalizationsDelegate();

  return [
    false,
    /*'/',
    {
      '/': (BuildContext context) => Home(),
    },*/
    getThemeData(context),
    [
      //appLocalizationsDelegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    [
      Locale('en', 'US'), // English
    ],
  ];
}

Widget appHome() {
  return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      iconSize: defaultIconSize - 12.0,
      activeColor: accentColor,
      inactiveColor: inactiveColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.calendar_active),
          title: Text("Calculator", textScaleFactor: 1.5,),
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.settings_active),
          title: Text("Settings", textScaleFactor: 1.5,),
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.about_active),
          title: Text("About", textScaleFactor: 1.5,),
        ),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return
          FormKeyboardActions(child: Home(index: index));
    },
  );
}
