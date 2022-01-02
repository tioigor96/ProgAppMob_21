//Schermata impostazioni
//TODO: controllo giallo<rosso
import 'package:Kambusapp/DB/db.dart';
import 'package:Kambusapp/DB/db_setting.dart';
import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/model/setting_model.dart';
import 'package:Kambusapp/view/list_product_view.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import '../common/utils.dart' as utils;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackNoSearchAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            SwitchListTile(
              activeColor: baseColor,
              title: Text('Notifiche'),
              subtitle: Text(
                  'Attiva o disattiva le notifiche per i prodotti in scadenza'),
              secondary: Icon(Icons.notifications, color: baseColor),
              onChanged: (value) {
                setState(() {
                  impostazioni.notifiche = BoolToInt(value);
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
              value: intToBool(impostazioni.notifiche),
            ),
            Divider(),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.access_time),
                  Text("Invia notifiche alle ore"),
                  Container(
                    width: 80,
                    child: TextFormField(
                      initialValue: impostazioni.time.format(context),
                      onTap: () => _selezionaData(context),
                      // decoration: InputDecoration(
                      //   hintText: impostazioni.time.format(context),
                      // ),
                      // onChanged: (value) => setState(() {
                      //   impostazioni.time = TimeOfDay(
                      //       hour: int.parse(value.split(":")[0]),
                      //       minute: int.parse(value.split(":")[1]));
                      //   DBSetting.dbSettings.update(impostazioni);
                      // }),
                      keyboardType: null,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: secondColor[600],
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                title: Text("Preavviso di giorni"),
                trailing: DropdownButton<int>(
                  value: impostazioni.notificaGialla,
                  items: <int>[
                    for (var i = impostazioni.notificaRossa + 1; i < 22; i += 1)
                      i
                  ].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      impostazioni.notificaGialla = value!;
                      DBSetting.dbSettings.update(impostazioni);
                    });
                  },
                )),

            //Divider(),
            ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: thirdColor[700],
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                title: Text("Preavviso di giorni"),
                trailing: DropdownButton<int>(
                  value: impostazioni.notificaRossa,
                  items: <int>[
                    for (var i = 1; i < impostazioni.notificaGialla; i += 1) i
                  ].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString() + "  "),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      impostazioni.notificaRossa = value!;
                      DBSetting.dbSettings.update(impostazioni);
                    });
                  },
                )),
            Divider(),
            Container(
              width: 40,
                child: Text(impostazioni.test)
            )
          ],
        ),
      ),
    );
  }

  void _selezionaData(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    print("${impostazioni.time}");
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: impostazioni.time,
      initialEntryMode: TimePickerEntryMode.input,
      cancelText: "ANNULLA",
      hourLabelText: "ORE",
      minuteLabelText: "MINUTI",
      errorInvalidText: "Inserisci un'ora valida"
    );
    if (newTime != null) {
      setState(() {
        impostazioni.time = newTime;
        DBSetting.dbSettings.update(impostazioni);
        impostazioni.test = newTime.format(context);
      });
    }
  }
}
