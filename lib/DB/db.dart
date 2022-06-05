//interazione con db

//TODO? un minimo di escape delle stringhe?

import 'package:Kambusapp/DB/db_setting.dart';
import 'package:Kambusapp/model/setting_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/product_model.dart';

class DBProdotti {
  late Database _db;

  DBProdotti._(); //costrutore con nome privato

  static final DBProdotti dbProdotti = DBProdotti._(); //creo istanza

  //tutte le operazioni su DB sono asincrone
  Future<Database> _getDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'prodotti.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE IF NOT EXISTS prodotti_bc"
            "(nome TEXT, "
            "quantita TEXT, "
            "marca TEXT, "
            "prezzo REAL, "
            "barcode TEXT PRIMARY KEY)");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS prodotti '
          '(id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'quantita TEXT, '
          'marca TEXT, '
          'prezzo REAL, '
          'scadenza TEXT, '
          'barcode TEXT)',
        );
      },
      version: 1,
    );
    return _db;
  }

  //trasforma map in prodotto
  Product productFromMap(Map inMap) {
    Product prod = Product();
    prod.id = inMap["id"];
    prod.nome = inMap["nome"];
    prod.quantita = inMap["quantita"];
    prod.scadenza = inMap["scadenza"];
    prod.marca = inMap["marca"];
    prod.prezzo = inMap["prezzo"];
    prod.barcode = inMap["barcode"];

    return prod;
  }

  Product old_productFromMap(Map inMap) {
    Product prod = Product();
    prod.nome = inMap["nome"];
    prod.quantita = inMap["quantita"];
    prod.marca = inMap["marca"];
    prod.prezzo = inMap["prezzo"];
    prod.barcode = inMap["barcode"];

    return prod;
  }

  //da prodotto a map
  Map<String, dynamic> productToMap(Product p) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = p.id;
    map["nome"] = p.nome;
    map["quantita"] = p.quantita;
    map["scadenza"] = p.scadenza;
    map["prezzo"] = p.prezzo;
    map["barcode"] = p.barcode;
    map["marca"] = p.marca;
    return map;
  }

  //inserimento prodotto
  /// return: true if i update the product in table prodotti_bc
  Future<bool> create(Product nuovo) async {
    bool result = false;
    Database db = await _getDB(); //ottenere DB
    var val = await db.rawQuery(
        "SELECT MAX(id) + 1 AS id FROM prodotti"); //rawquery per cassaggio diretto di query come stringa
    var id = val.first["id"]; //first perchè ritorna tutti gli id massimi
    id ??= 1;
    if (nuovo.barcode != null && nuovo.barcode!.length >= 10) {
      Product p = await get_from_barcode(nuovo.barcode
          .toString()); //vedo se devo mostrare che aggiorno o cosa!
      result = !p.equivalent(nuovo);
      await db.rawInsert(
          "INSERT OR REPLACE INTO prodotti_bc (nome, quantita, marca, prezzo, barcode) "
          "VALUES (?, ?, ?, ?, ?)",
          [
            nuovo.nome,
            nuovo.quantita,
            nuovo.marca,
            nuovo.prezzo,
            nuovo.barcode
          ]);
    }
    await db.rawInsert(
        "INSERT INTO prodotti (id, nome, quantita, marca, prezzo, scadenza, barcode) "
        "VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          id,
          nuovo.nome,
          nuovo.quantita,
          nuovo.marca,
          nuovo.prezzo,
          nuovo.scadenza,
          nuovo.barcode
        ]);
    return result;
  }

  Future<List> getAll(Setting impostazioni) async {
    Database db = await _getDB();
    String order = impostazioni.ordinamento + " " + impostazioni.ascDesc;
    var recs = await db.query("prodotti", orderBy: order);
    var list = recs.isEmpty ? [] : recs.map((m) => productFromMap(m)).toList();
    return list;
  }

  Future<List> searchFromDB(String param, int selected) async {
    String query = "";
    switch (selected) {
      case 1:
        query = "SELECT * FROM prodotti WHERE quantita LIKE '%" + param + "%'";
        break;
      case 2:
        query = "SELECT * FROM prodotti WHERE marca LIKE '%" + param + "%'";
        break;
      default:
        query = "SELECT * FROM prodotti WHERE nome LIKE '%" + param + "%'";
        break;
    }

    Database db = await _getDB();
    var recs = await db.rawQuery(query);
    var list = recs.isEmpty ? [] : recs.map((m) => productFromMap(m)).toList();
    return list;
  }

  Future update(Product nuovo) async {
    Database db = await _getDB();
    return await db.update("prodotti", productToMap(nuovo),
        where: "id = ?", whereArgs: [nuovo.id]); //da note a map
  }

  Future delete(int inID) async {
    Database db = await _getDB();
    return await db.delete("prodotti", where: "id = ?", whereArgs: [inID]);
  }

  Future deleteAll() async {
    Database db = await _getDB();
    return await db.delete("prodotti");
  }

  Future<Product> get_from_barcode(String barcode) async {
    Database db = await _getDB();
    Product prod;
    var rec = await db
        .rawQuery("SELECT * FROM prodotti_bc WHERE barcode = ?", [barcode]);

    if (rec.isNotEmpty) {
      prod = old_productFromMap(rec.first);
    } else {
      prod = Product();
      prod.barcode = barcode;
    }
    return prod;
  }

  Future<int> nearExpiration() async {
    int redflag = 3, counter = 0;
    DBSetting.dbSettings.get().then((value) => redflag = value.notificaRossa);
    Database db = await _getDB();
    DateTime today = DateTime.now();

    List prods = await db.rawQuery("SELECT * FROM prodotti");
    prods.forEach((e) {
      String scadenza = e['scadenza'];
      DateTime prodScad = DateTime(int.parse(scadenza.split("-")[0]),
          int.parse(scadenza.split("-")[1]), int.parse(scadenza.split("-")[2]));

      if (prodScad.difference(today).inDays >= 0 &&
          prodScad.difference(today).inDays <= redflag) {
        counter++;
      }
    });
    return counter;
  }

  Future<int> expired() async {
    int counter = 0;
    Database db = await _getDB();
    DateTime today = DateTime.now();

    List prods = await db.rawQuery("SELECT * FROM prodotti");
    prods.forEach((e) {
      String scadenza = e['scadenza'];
      DateTime prodScad = DateTime(int.parse(scadenza.split("-")[0]),
          int.parse(scadenza.split("-")[1]), int.parse(scadenza.split("-")[2]));

      if (prodScad.difference(today).inDays < 0) {
        counter++;
      }
    });

    return counter;
  }
}
