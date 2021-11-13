//widget riutilizzabili in diverse schermate

import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../model/product_model.dart';

class ReusableWidget {
  //App bar
  static getAppBar() {
    return AppBar(
      title: const Text('Kambusapp',
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
          ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }

  //AppBar con back
  static getBackAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            productModel.prodottoSelezionato = Product();
            productModel.setStackIndex(0);
          }),
      title: const Text('AppName',
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
          ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              // do something
            }),
      ],
    );
  }
}
