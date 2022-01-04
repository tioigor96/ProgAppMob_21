//definizione di prodotti

import 'package:Kambusapp/model/setting_model.dart';
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

  bool selezionato = false; //uso in eliminazione multipla

  Product() {
    scadenza = "";
  }

  String prezzoToString() {
    return prezzo == null ? "" : prezzo.toString();
  }

  bool equivalent(Product p) {
    if (nome != p.nome ||
        marca != p.marca ||
        prezzo != p.prezzo ||
        quantita != p.quantita) {
      return false;
    }

    return true;
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
    listaProdotti = await inDatabaseWorker.getAll(impostazioni);
    notifyListeners();
  }

  void setProdotti(List prodotti) {
    listaProdotti = prodotti;
    notifyListeners();
  }

  void eliminaProdotto(dynamic inDatabaseWorker, int id) async {
    await inDatabaseWorker.delete(id);
  }

  void eliminaMultiplo(dynamic inDatabaseWorker) {
    for (int i = 0; i < this.listaProdotti.length; i++) {
      if (this.listaProdotti.elementAt(i).selezionato) {
        eliminaProdotto(inDatabaseWorker, this.listaProdotti.elementAt(i).id);
      }
    }
  }
}

ProductModel productModel = ProductModel();
