import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/view/arrow_back.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'model/notification.dart';
import 'model/page_manager.dart';
import 'common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  manager.nuovaPagina(0);
  SharedPreferences s = await SharedPreferences.getInstance();
  // print("flag " + s.get('flag').toString());
  if (s.get('flag') == null) {
    // print("null");
    s.setInt('flag', 0);
    s.setInt('add', 0);
    flag = 0;
    numeroAdd = 0;
  }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(AppMobile());
}

class AppMobile extends StatelessWidget {
  Future<void> _initAlarms() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AndroidAlarmManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    //set notification
    notification.init();
    _initAlarms();
    MaterialApp ma = MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en', ''), const Locale('it', '')],
      locale: Locale("it"),
      title: manager.getAppName(),
      theme: ThemeData(
        primarySwatch: baseColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //onPrimary: secondColor,
            primary: secondColor,
          ),
        ),
      ),
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) {},
          onComplete: (index, key) {},
          blurValue: 1,
          builder: Builder(builder: (context) => ArrowBack()),
          autoPlay: false,
          autoPlayDelay: const Duration(seconds: 3),
          autoPlayLockEnable: false,
        ),
      ),
    );
    FlutterNativeSplash.remove();
    return ma;
  }
}
