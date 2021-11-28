//interazione con db

//TODO? un minimo di escape delle stringhe?

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../common/utils.dart' as utils;
import '../model/product_model.dart';

class DBProdotti {
  late Database _db;
  int creato = 0;

  DBProdotti._(); //costrutore con nome privato

  static final DBProdotti dbProdotti = DBProdotti._(); //creo istanza

  /* Database _createDB ()
  {
    openDatabase(join(utils.docsDir!.path, "prodotti.db"),
    onCreate: (inDB, version) {
      return inDB.execute(
  'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  );
  },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
  }*/

  //tutte le operazioni su DB sono asincrone
  Future<Database> _getDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'prodotti.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS prodotti (id INTEGER PRIMARY KEY, nome TEXT, quantita TEXT, marca TEXT, prezzo REAL, scadenza TEXT, barcode TEXT)',
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

    print(prod.nome +
        " " +
        prod.quantita +
        " " +
        prod.scadenza.toString() +
        " " +
        prod.marca.toString() +
        " " +
        prod.prezzo.toString() +
        " " +
        prod.barcode.toString());

    return prod;
  }

  /*
  //da note a map
  Map<String, dynamic> noteToMap(Note inNote) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inNote.id;
    map["title"] = inNote.title;
    map["content"] = inNote.content;
    map["color"] = inNote.color;
    return map;
  }
*/

  //inserimento prodotto
  Future create(Product nuovo) async {
    Database db = await _getDB(); //ottenere DB
    var val = await db.rawQuery(
        "SELECT MAX(id) + 1 AS id FROM prodotti"); //rawquery per cassaggio diretto di query come stringa
    var id = val.first["id"]; //first perchè ritorna tutti gli id massimi
    if (id == null) {
      id = 1;
    }
    return await db.rawInsert(
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
  }

  //estrarre nota
  Future<Product> get(int inID) async {
    Database db = await _getDB();
    var rec = await db.query("prodotti"); //non passo query ma sfrutto parametri
    return productFromMap(rec.first); //conversione da map a note
  }

  Future<List> getAll() async {
    Database db = await _getDB();
    var recs = await db.query("prodotti");
    var list = recs.isEmpty ? [] : recs.map((m) => productFromMap(m)).toList();
    return list;
  }

  Future<List> searchFromDB(String param, int selected) async
  {
    String query="";
    switch(selected)
    {
      case 1:
        query="SELECT * FROM prodotti WHERE quantita LIKE '%"+param+"%'";
        break;
      case 2:
        query="SELECT * FROM prodotti WHERE quantita LIKE '%"+param+"%'";
        break;
      default:
        query="SELECT * FROM prodotti WHERE nome LIKE '%"+param+"%'";
        break;
    }

    Database db = await _getDB();
    var recs = await db.rawQuery(query);
    var list = recs.isEmpty ? [] : recs.map((m) => productFromMap(m)).toList();
    return list;
  }




/*
  Future update(Note inNote) async {
    Database db = await _getDB();
    return await db.update("notes", noteToMap(inNote), where: "id = ?", whereArgs: [inNote.id]);    //da note a map
  }

  Future delete(int inID) async {
    Database db = await _getDB();
    return await db.delete("notes", where: "id = ?", whereArgs: [inID]);
  }
*/

  Future deleteAll() async {
    Database db = await _getDB();
    return await db.delete("prodotti");
  }
}
