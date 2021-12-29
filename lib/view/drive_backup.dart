//Schermata impostazioni

import 'package:Kambusapp/DB/db.dart';
import 'package:Kambusapp/DB/db_setting.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/model/setting_model.dart';
import 'package:Kambusapp/view/list_product_view.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import '../common/utils.dart' as utils;
import 'package:flutter_slidable/flutter_slidable.dart';

class BackupView extends StatefulWidget {
  @override
  State<BackupView> createState() => _BackupViewState();
}

class _BackupViewState extends State<BackupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackNoSearchAppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Ora ti popolo!")
          ],
        ),
      ),
    );
  }
}
