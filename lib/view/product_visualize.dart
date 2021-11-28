//visualizzaizone lista di prodotti

import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/list_product_view.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import '../common/utils.dart' as utils;
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getAppBar(),
      body: ListProduct(),
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
