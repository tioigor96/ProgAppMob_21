import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/product_view_change.dart';
import 'package:flutter/cupertino.dart';

class ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        productModel.caricaProdotti(DBProdotti.dbProdotti);
        productModel.setStackIndex(manager.precedente());
        // print(manager.page.length.toString());
        return manager.page.length <= 1 ? true : false;
      }),
      child: ProductsChange(),
    );
  }
}
