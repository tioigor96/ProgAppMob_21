//visualizzaizone lista di prodotti

import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/add_view.dart';
import 'package:Kambusapp/view/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../common/colors.dart';
import 'add_view.dart';
import 'widget.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getAppBar(),
      body: ListProduct(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences s = await SharedPreferences.getInstance();
          int? add = s.getInt('add');
          s.setInt('add', add! + 1);
          print("add " + add.toString());
          numeroAdd = add + 1;
          if (numeroAdd! <= 2) {
            print("mostro showcase");
            //ShowCaseWidget.of(context)!.startShowCase([barcodeHint]);
            //ShowCaseWidget.of(context)!.startShowCase([barcodeHint]);
            if (flag == 0) //togliere se problemi
            {
              print("showcase pallino");
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  ShowCaseWidget.of(context)!
                      .startShowCase([barcodeHint, chiave]));
              //ShowCaseWidget.of(context)!.startShowCase([chiave]);
              setFlag(1);
            }
            else{
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  ShowCaseWidget.of(context)!
                      .startShowCase([barcodeHint]));
            }
          }
          productModel.prodottoSelezionato = Product();
          productModel.prodottoSelezionato!.id = -1;
          productModel.setStackIndex(1);
          manager.nuovaPagina(1);
        },
        backgroundColor: secondColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future setFlag(int f) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setInt('flag', f);
  }
}
