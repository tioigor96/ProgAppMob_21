//Schermata impostazioni

import 'package:Kambusapp/DB/db_setting.dart';
import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/model/notification.dart';
import 'package:Kambusapp/model/setting_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackNoSearchAppBar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            SwitchListTile(
              activeColor: baseColor,
              title: const Text('Notifiche'),
              subtitle: const Text(
                  'Attiva o disattiva le notifiche per i prodotti in scadenza'),
              secondary: Icon(Icons.notifications, color: baseColor),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _scheduleNotification();
                    impostazioni.notifiche = 1;
                  } else {
                    _deleteNotification();
                    impostazioni.notifiche = 0;
                  }
                  impostazioni.notifiche = BoolToInt(value);
                  DBSetting.dbSettings.update(impostazioni);
                });
              },
              value: intToBool(impostazioni.notifiche),
            ),
            const Divider(),
            ListTile(
              leading: Container(
                child: const Icon(Icons.access_time),
                width: 20,
                height: 20,
              ),
              title: Text(
                "Invia notifiche alle ore",
                style: TextStyle(
                    color: impostazioni.notifiche == 0
                        ? Colors.grey
                        : Colors.black),
              ),
              trailing: Container(
                key: UniqueKey(),
                width: 50,
                child: (TextFormField(
                  initialValue: impostazioni.time.format(context),
                  enabled: impostazioni.notifiche == 0 ? false : true,
                  onTap: () => _selezionaData(context),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: impostazioni.notifiche == 0
                          ? Colors.grey
                          : Colors.black),
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
                )),
              ),
            ),
            ListTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: secondColor[600],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                title: const Text("Preavviso di giorni"),
                subtitle:
                    Text("Il pallino giallo indica il prodotto che scadrà tra"
                        " ${impostazioni.notificaGialla} giorni"),
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
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                title: const Text("Preavviso di giorni"),
                subtitle: Text(
                    "Il pallino rosso indica il prodotto che scadrà tra ${impostazioni.notificaRossa} giorni"),
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
          ],
        ),
      ),
    );
  }

  void _deleteNotification() async => notification.deleteNotification();

  void _scheduleNotification() async =>
      notification.scheduleNotification(impostazioni.time);

  void _selezionaData(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // print("${impostazioni.time}");
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: impostazioni.time,
        initialEntryMode: TimePickerEntryMode.input,
        cancelText: "ANNULLA",
        hourLabelText: "ORE",
        minuteLabelText: "MINUTI",
        errorInvalidText: "Inserisci un'ora valida");
    if (newTime != null) {
      setState(() {
        impostazioni.time = newTime;
        DBSetting.dbSettings.update(impostazioni);
      });
      //reschedule all notifications
      _deleteNotification();
      _scheduleNotification();
    }
  }
}
