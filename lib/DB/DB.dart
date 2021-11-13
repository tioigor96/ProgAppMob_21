//interazione con db

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../common/utils.dart' as utils;
import '../model/product_model.dart';

class DBProdotti {

  DBProdotti._();              //costrutore con nome privato
  static final DBProdotti dbProdotti = DBProdotti._();         //creo istanza

  Database? _db;


  //tutte le operazioni su DB sono asincrone
  Future<Database?> _getDB() async {
    if(_db==null){        //se non ho inizializzato db, inizializzo
      String path = join(utils.docsDir!.path, "prodotti.db");     //percorso di file con D.
      _db = await openDatabase(path, version: 1,              //apro DB
          onCreate: (Database inDB, int inVersion) async {
            await inDB.execute("CREATE TABLE IF NOT EXISTS notes ("
                "id INTEGER PRIMARY KEY,"
                "nome TEXT,"
                "quantita TEXT,"
                "marca TEXT,"
                "prezzo REAL"
                "scadenza TEXT"
                "barcode TEXT"
                ")");
          });
    }
    return _db;
  }

  /*
  //trasforma map in note
  Note noteFromMap(Map inMap){
    Note note = Note();
    note.id = inMap["id"];
    note.title = inMap["title"];
    note.content = inMap["content"];
    note.color = inMap["color"];
    return note;
  }

  //da note a map
  Map<String, dynamic> noteToMap(Note inNote) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inNote.id;
    map["title"] = inNote.title;
    map["content"] = inNote.content;
    map["color"] = inNote.color;
    return map;
  }

  //creazione nuova nota
  Future create(Note inNote) async {
    Database db = await _getDB();       //ottenere DB
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM notes");         //rawquery per cassaggio diretto di query come stringa
    int id = val.first["id"];       //first perchè ritorna tutti gli id massimi
    if (id==null){
      id = 1;
    }
    return await db.rawInsert(
        "INSERT INTO notes (id, title, content, color) "
            "VALUES (?, ?, ?, ?)",
        [id, inNote.title, inNote.content, inNote.color]
    );
  }

  //estrarre nota
  Future<Note> get(int inID) async {
    Database db = await _getDB();
    var rec = await db.query("notes", where: "id = ?", whereArgs: [inID]);      //non passo query ma sfrutto parametri
    return noteFromMap(rec.first);         //conversione da map a note
  }

  Future<List> getAll() async {
    Database db = await _getDB();
    var recs = await db.query("notes");
    var list = recs.isEmpty ? [] : recs.map((m) => noteFromMap(m)).toList();     //è un if in linea
    return list;
  }

  Future update(Note inNote) async {
    Database db = await _getDB();
    return await db.update("notes", noteToMap(inNote), where: "id = ?", whereArgs: [inNote.id]);    //da note a map
  }

  Future delete(int inID) async {
    Database db = await _getDB();
    return await db.delete("notes", where: "id = ?", whereArgs: [inID]);
  }
*/
}