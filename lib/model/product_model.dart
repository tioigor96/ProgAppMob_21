//definizione di prodotti

import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:notebook/db/notes_db_worker.dart';

class Product {
  int id = 0;
  String nome = "";
  String quantita = "";
  String? marca;
  double? prezzo;
  DateTime? scadenza;
  String? barcode;
}

class ProductModel extends ChangeNotifier {
  int stackIndex = 0;
  List listaProdotti = [];              //lista dei prodotti inseriti da utente
  Product? prodottoSelezionato;          //prodotto da modificare o visualizzare

  void setStackIndex(int inStackIndex){                 //per modificare stack index
    stackIndex = inStackIndex;
    notifyListeners();
  }

/*  void loadData(dynamic inDatabaseWorker) async {       //dynamic determina il tipo a runtme
    ProductList = await inDatabaseWorker.getAll();        //per ottenere tutte le note
    notifyListeners();
  }
*/
}

ProductModel productModel = ProductModel();


