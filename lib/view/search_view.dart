/*Schermata di ricerca
 */

import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:Kambusapp/view/widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../common/colors.dart';
import 'package:getwidget/getwidget.dart';
import 'package:Kambusapp/view/list_product_view.dart';

import 'add_view.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var msgController = TextEditingController();
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  msgController.clear();
                  FocusScope.of(context).requestFocus(new FocusNode());
                  productModel.caricaProdotti(DBProdotti.dbProdotti);
                  productModel.setStackIndex(manager.precedente());
                }),
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: msgController,
                  style: TextStyle(color: Colors.white),
                  //da commentare se voglio scrivere in nero
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () async {
                          var prod = await DBProdotti.dbProdotti
                              .searchFromDB(msgController.text, selected);
                          productModel.setProdotti(prod);
                        },
                      ),
                      hintText: 'Cerca...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none),
                ),
              ),
            )),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: baseColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GFButton(
                      color: selected == 0 ? Colors.white54 : Colors.white,
                      shape: GFButtonShape.pills,
                      size: GFSize.SMALL,
                      text: "Nome",
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          selected = 0;
                        });
                      }),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: GFButton(
                        color: selected == 1 ? Colors.white54 : Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Quantità",
                        textColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            selected = 1;
                          });
                        }),
                  ),
                  GFButton(
                      color: selected == 2 ? Colors.white54 : Colors.white,
                      shape: GFButtonShape.pills,
                      size: GFSize.SMALL,
                      text: "Marca",
                      textColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          selected = 2;
                        });
                      }),
                ],
              ),
            ),
            Expanded(child: ListProduct()),
          ],
        ),
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
      ),
    );
  }

  Future setFlag(int f) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setInt('flag', f);
  }
}
