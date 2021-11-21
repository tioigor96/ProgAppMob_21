import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'common/utils.dart' as utils;
import 'package:Kambusapp/assets/constants.dart' as Constants;
import 'package:path_provider/path_provider.dart';
import 'view/product_view_change.dart';
import 'view/product_visualize.dart';
import 'common/colors.dart';


void main() async {
  //WidgetsFlutterBinding
  //    .ensureInitialized(); //obbligatorio per poter aggiungere codice prima di runApp
  //String docsDir =
  //    await getDatabasesPath(); //get del path di DB
 // utils.docsDir = docsDir;
  runApp(AppMobile());
}

class AppMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Constants.appName,
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
  }
}
