//visualizzaizone lista di prodotti

import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import '../common/utils.dart' as utils;
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(productModel.listaProdotti.length);
    return Scaffold(
      appBar: ReusableWidget.getAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView.builder(
          itemCount: productModel.listaProdotti.length,                       //numero di note da visualizzare
          itemBuilder: (BuildContext inBuildContext, int inIndex) { //funzione che viene chiamata per ogni elemento della lista. Index è indice di elemento che sta caricando
            Product p = productModel.listaProdotti[inIndex];
            return ReusableWidget.getExpansionProduct(p);
          }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productModel.prodottoSelezionato = Product();
          productModel.prodottoSelezionato!.id = -1;
          productModel.setStackIndex(1);
        },
        backgroundColor: secondColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
