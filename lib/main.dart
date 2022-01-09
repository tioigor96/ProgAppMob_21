import 'package:Kambusapp/common/utils.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'model/notification.dart';
import 'model/page_manager.dart';
import 'view/product_view_change.dart';
import 'common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences s = await SharedPreferences.getInstance();
  print("flag " + s.get('flag').toString());
  if (s.get('flag') == null) {
    print("null");
    s.setInt('flag', 0);
    s.setInt('add', 0);
    flag = 0;
    numeroAdd = 0;
  }
  print("flag  " + flag.toString());
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
    return MaterialApp(
      title: manager.getAppName(),
      theme: ThemeData(
        primarySwatch: baseColor,
        appBarTheme: AppBarTheme(
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
          builder: Builder(builder: (context) => ProductsChange()),
          autoPlay: false,
          autoPlayDelay: Duration(seconds: 3),
          autoPlayLockEnable: false,
        ),
      ),
    );
  }
}
