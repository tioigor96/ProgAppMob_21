//parte del codice che specifica le diverse pagine tra cui navigare

import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/add_view.dart';
import 'package:Kambusapp/view/search_view.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import 'package:provider/provider.dart';
import '../view/product_visualize.dart';
import '../DB/DB.dart';

class ProductsChange extends StatelessWidget {
  ProductsChange() {
     productModel.caricaProdotti(DBProdotti.dbProdotti);     //per avere lista di note
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: productModel,
      child: Consumer<ProductModel>(
        builder: (context, notesModel, child) {
          return IndexedStack(
            //permette di visualizzare solo uno dei figli in base a index
            index: productModel.stackIndex,
            children: [ProductsView(), AddView(), SearchView()],
          );
        },
      ),
    );
  }
}
