import 'package:flutter/material.dart';
import 'model/notification.dart';
import 'model/page_manager.dart';
import 'view/product_view_change.dart';
import 'common/colors.dart';

void main() async {
  runApp(AppMobile());
}

class AppMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp ma = MaterialApp(
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
        home: ProductsChange());

    //set notification
    //TODO: sistema il context, va in errore
    Future selectNotification(String? payload) async {
      await Navigator.push(context, MaterialPageRoute<void>(builder: (context) {
        return AppMobile();
      }));
    }

    notification.init(selectNotification);

    //start app
    return ma;
  }
}
