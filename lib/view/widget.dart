//widget riutilizzabili in diverse schermate

import 'package:Kambusapp/assets/constants.dart' as Constants;
import 'package:Kambusapp/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../common/colors.dart';
import '../model/product_model.dart';
import '../common/utils.dart' as utils;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../DB/DB.dart';

class ReusableWidget {
  //App bar
  static getAppBar() {
    return AppBar(
      title: const Text(Constants.appName,
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
          ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              productModel.setStackIndex(2);
            }),
        PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Impostazioni notifiche"),
                onTap: (){
                  productModel.setStackIndex(3);
                },
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Impostazioni visualizzazione"),
                onTap: (){
                  productModel.setStackIndex(4);
                },
                value: 2,
              )
            ]
        )
      ],
    );
  }

  //AppBar con back
  static getBackAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            productModel.caricaProdotti(DBProdotti.dbProdotti);
            productModel.setStackIndex(0);
          }),
      title: const Text(Constants.appName,
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
          ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            productModel.setStackIndex(2);
          },
        ),
        PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Impostazioni notifiche"),
                onTap: (){
                  productModel.setStackIndex(3);
                },
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Impostazioni visualizzazione"),
                onTap: (){
                  productModel.setStackIndex(4);
                },
                value: 2,
              )
            ]
        )
      ]
      ,
    );
  }

/*
  static getSearchAppBar() {
    return
  }
*/
  static getExpansionProduct(p) {
    return Column(
      children: [
        ExpansionTile(
          title: getTitle(p),
          subtitle: TextFormField(
            enabled: false,
            initialValue: p.quantita,
            readOnly: true,
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: "Quantità",
              labelStyle: TextStyle(color: Colors.grey),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    initialValue: p.scadenza,
                    readOnly: true,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      labelText: "Scadenza",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: p.marca == null ? " " : p.marca,
                    readOnly: true,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      labelText: "Marca",
                      labelStyle: TextStyle(color: Colors.grey),
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
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            productModel.prodottoSelezionato = p;
                            productModel.setStackIndex(1);
                          }),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //TODO eliminare
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //pallino a destra
  static getExpansionProduct2(p) {
    return Column(
      children: [
        ExpansionTile(
          title: getTitleBallRight(p),
          controlAffinity: ListTileControlAffinity.leading,
          subtitle: TextFormField(
            enabled: false,
            initialValue: p.quantita,
            readOnly: true,
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: "Quantità",
              labelStyle: TextStyle(color: baseColor),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(75, 0, 15, 0),
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            productModel.prodottoSelezionato = p;
                            productModel.setStackIndex(1);
                          }),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //TODO eliminare
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }


  static getExpansionProduct3(p) {
    return Column(
      children: [
        GestureDetector(
          onLongPressDown: (d){
            //TODO: qui implemento il long press
            print("long press");
            },
          child: ExpansionTile(
            title: getTitleBallRight(p),
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
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            productModel.prodottoSelezionato = p;
                            productModel.setStackIndex(1);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.edit),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {

                          },
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.delete),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  static getTitle(Product p) {
    if ((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <=
        impostazioni.notificaRossa) {
      return Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: thirdColor[700],
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
          Container(
            width: 10,
          ),
          Text(p.nome.capitalize()),
        ],
      );
    } else {
      if ((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <=
          impostazioni.notificaGialla) {
        return Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: secondColor[600],
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            Container(
              width: 10,
            ),
            Text(p.nome.capitalize()),
          ],
        );
      } else {
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            Container(
              width: 10,
            ),
            Text(p.nome.capitalize()),
          ],
        );
      }
    }
  }

  static getTitleBallRight(Product p) {
    if ((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <=
        impostazioni.notificaRossa) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(p.nome.capitalize()),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              // padding: EdgeInsets.fromLTRB(0, 200, 200, 0),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: thirdColor[700],
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
        ],
      );
    } else {
      if ((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <=
          impostazioni.notificaGialla) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(p.nome.capitalize()),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: secondColor[600],
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(p.nome.capitalize()),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: 20,
                height: 20,
              ),
            ),
          ],
        );
      }
    }
  }
}
