import 'package:Kambusapp/DB/db_setting.dart';
import 'package:flutter/material.dart';

class Setting {
  int notifiche = 1;
  int notificaGialla = 1;
  int notificaRossa = 0;
  String ordinamento = "nome";
  String ascDesc = "asc";
  TimeOfDay time = TimeOfDay(hour: 9, minute: 00);

  void aggiorna(dynamic inDatabaseWorker) async {
    await inDatabaseWorker.get().then((result) {
      notifiche = result.notifiche;
      notificaGialla = result.notificaGialla;
      notificaRossa = result.notificaRossa;
      ordinamento = result.ordinamento;
      ascDesc = result.ascDesc;
      time = result.time;
    });
  }
}

Setting impostazioni = new Setting();
