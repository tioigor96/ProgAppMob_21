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

class OrderView extends StatefulWidget {
  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackNoSearchAppBar(),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text("Visualizzazione dei prodotti"),
              subtitle: Text("Voglio visualizzare i prodotti ordinati per"),
            ),
            RadioListTile<String>(
              title: const Text('Nome'),
              value: 'nome',
              groupValue: impostazioni.ordinamento,
              onChanged: (value) {
                setState(() {
                  impostazioni.ordinamento = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Data di scadenza'),
              value: 'scadenza',
              groupValue: impostazioni.ordinamento,
              onChanged: (value) {
                setState(() {
                  impostazioni.ordinamento = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Marca'),
              value: 'marca',
              groupValue: impostazioni.ordinamento,
              onChanged: (value) {
                setState(() {
                  impostazioni.ordinamento = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Prezzo'),
              value: 'prezzo',
              groupValue: impostazioni.ordinamento,
              onChanged: (value) {
                setState(() {
                  impostazioni.ordinamento = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
            Divider(),
            RadioListTile<String>(
              title: const Text('Crescente'),
              value: 'asc',
              groupValue: impostazioni.ascDesc,
              onChanged: (value) {
                setState(() {
                  impostazioni.ascDesc = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Decrescente'),
              value: 'desc',
              groupValue: impostazioni.ascDesc,
              onChanged: (value) {
                setState(() {
                  impostazioni.ascDesc = value!;
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
