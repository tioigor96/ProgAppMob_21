//interazione con db

//TODO? un minimo di escape delle stringhe?

import 'package:Kambusapp/model/setting_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../common/utils.dart' as utils;
import '../model/product_model.dart';

class DBSetting {
  late Database _settings;

  DBSetting._(); //costrutore con nome privato

  static final DBSetting dbSettings = DBSetting._(); //creo istanza


  Future<Database> _getDBSettings() async {
    _settings = await openDatabase(
      join(await getDatabasesPath(), 'impostazioni.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE IF NOT EXISTS impostazioni (id INTEGER PRIMARY KEY, notifiche INT, gialla INT, rossa INT, ordinamento STRING, crescente STRING)',
        );
        db.execute(
          'INSERT INTO impostazioni (notifiche, gialla, rossa, ordinamento, crescente) values (1, 5, 3, \'nome\', \'asc\')',
        );
      },
      version: 1,
    );
    return _settings;
  }

  //trasforma map in setting
  Setting settingFromMap(Map inMap) {
    Setting impostazioni = Setting();
    impostazioni.notificaRossa=inMap['rossa'];
    impostazioni.notificaGialla=inMap['gialla'];
    impostazioni.notifiche=inMap['notifiche'];
    impostazioni.ordinamento=inMap['ordinamento'];
    impostazioni.ascDesc=inMap['crescente'];


    print("stampo impostazioni: " +impostazioni.notifiche.toString() +
        " " +
        impostazioni.notificaGialla.toString() +
        " " +
        impostazioni.notificaRossa.toString());
    return impostazioni;
  }


  //da setting a map
  Map<String, dynamic> settingToMap(Setting i) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["notifiche"] = i.notifiche;
    map["gialla"] = i.notificaGialla;
    map["rossa"] = i.notificaRossa;
    map["ordinamento"] = i.ordinamento;
    map["crescente"] = i.ascDesc;
    return map;
  }

  //estrarre impostazioni
  Future<Setting> get() async {
    Database db = await _getDBSettings();
    var rec = await db.query("impostazioni");
    return settingFromMap(rec.first);
  }

  Future update(Setting nuovo) async {
    Database db = await _getDBSettings();
    return await db.update("impostazioni", settingToMap(nuovo));    //da note a map
  }

  Future deleteAll() async {
    Database db = await _getDBSettings();
    return await db.delete("impostazioni");
  }


}