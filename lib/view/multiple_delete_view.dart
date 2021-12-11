//visualizzaizone lista di prodotti

import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/list_product_view.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import '../common/utils.dart' as utils;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Kambusapp/assets/constants.dart' as Constants;

class MultipleDelete extends StatefulWidget {
  @override
  State<MultipleDelete> createState() => _MultipleDeleteState();
}

class _MultipleDeleteState extends State<MultipleDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              productModel.caricaProdotti(DBProdotti.dbProdotti);
              productModel.setStackIndex(manager.precedente());
            }),
        title: Text(manager.getAppName(),
            style: TextStyle(
                color: Colors.white) //da commentare se voglio titolo nero
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              productModel.eliminaMultiplo(DBProdotti.dbProdotti);
              productModel.caricaProdotti(DBProdotti.dbProdotti);
              productModel.setStackIndex(manager.precedente());
            },
          ),
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Impostazioni notifiche"),
                  onTap: () {
                    productModel.setStackIndex(3);
                    manager.nuovaPagina(3);
                  },
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Impostazioni visualizzazione"),
                  onTap: () {
                    productModel.setStackIndex(4);
                    manager.nuovaPagina(4);
                  },
                  value: 2,
                )
              ]
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productModel.listaProdotti.length,
        itemBuilder: (context, index) {
          Product p = productModel.listaProdotti[index];
          return Column(
            children: [
              GestureDetector(
                onLongPress: () {
                  productModel.setStackIndex(5);
                  manager.nuovaPagina(5);
                },
                child: ExpansionTile(
                  title: Text(p.nome.capitalize()),
                  trailing: Checkbox(
                    value: p.selezionato,
                    onChanged: (value){
                      setState(() {
                        p.selezionato=!p.selezionato;
                    });},
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(72, 0, 15, 0),
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: false,
                            initialValue: p.quantita,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelText: "Quantità",
                              labelStyle: TextStyle(color: baseColor),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            initialValue: p.scadenza,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelText: "Scadenza",
                              labelStyle: TextStyle(color: baseColor),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            initialValue: p.marca == null ? " " : p.marca,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelText: "Marca",
                              labelStyle: TextStyle(color: baseColor),
                            ),
                          ),
                          TextFormField(
                            enabled: false,
                            initialValue:
                            p.prezzo == null ? " " : "€ " + p.prezzo.toString(),
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelText: "Prezzo",
                              labelStyle: TextStyle(color: baseColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }



}
