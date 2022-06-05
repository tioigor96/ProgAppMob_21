//parte del codice che specifica le diverse pagine tra cui navigare

import 'package:Kambusapp/DB/db_setting.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/model/setting_model.dart';
import 'package:Kambusapp/view/add_view.dart';
import 'package:Kambusapp/view/multiple_delete_view.dart';
import 'package:Kambusapp/view/search_view.dart';
import 'package:flutter/material.dart';
import 'order_view.dart';
import 'package:provider/provider.dart';
import '../view/product_visualize.dart';
import '../view/settings_view.dart';
import '../DB/db.dart';

class ProductsChange extends StatelessWidget {
  ProductsChange({Key? key}) : super(key: key) {
    impostazioni.aggiorna(DBSetting.dbSettings); //info notifiche
    // print(impostazioni.notificaGialla);
    productModel
        .caricaProdotti(DBProdotti.dbProdotti); //per avere lista di prodotti
    manager.nuovaPagina(0);
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
            children: [
              ProductsView(),
              AddView(),
              SearchView(),
              SettingsView(),
              OrderView(),
              MultipleDelete()
            ],
          );
        },
      ),
    );
  }
}
