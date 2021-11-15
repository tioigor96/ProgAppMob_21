//visualizzaizone lista di prodotti

import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getAppBar(),
      body: Scaffold(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productModel.prodottoSelezionato = Product();
          productModel.setStackIndex(1);
        },
        backgroundColor: secondColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
