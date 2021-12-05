//definizione di prodotti

import 'dart:ffi';
import 'package:flutter/material.dart';

class Product {
  int id = 0;
  String nome = "";
  String quantita = "";
  String? marca;
  double? prezzo;
  String? prezzoString;
  late String scadenza;
  String? barcode;

  Product() {
    scadenza = "";
  }


  String prezzoToString() {
    if (prezzo == null) {
      return "";
    } else {
      return prezzo.toString();
    }
  }
}

class ProductModel extends ChangeNotifier {
  int stackIndex = 0;
  List listaProdotti = []; //lista dei prodotti inseriti da utente
  Product? prodottoSelezionato; //prodotto da modificare o visualizzare

  ProductModel() {
    prodottoSelezionato = new Product();
  }

  void setStackIndex(int inStackIndex) {
    //per modificare stack index
    stackIndex = inStackIndex;
    notifyListeners();
  }

  void caricaProdotti(dynamic inDatabaseWorker) async {
    listaProdotti = await inDatabaseWorker.getAll();
    notifyListeners();
  }

  void setProdotti(List prodotti) {
    listaProdotti = prodotti;
    notifyListeners();
  }

}

ProductModel productModel = ProductModel();
