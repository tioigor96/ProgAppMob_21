//schermata inserimento di un prodotto

//TODO? Vogliamo fare in modo che una volta completato un field ci sia l'autofocus a quello successivo?

import 'package:Kambusapp/DB/db.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/colors.dart';
import 'widget.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class AddView extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Nome", hintText: "Pane"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.nome,
                    validator: (String? inValue) {
                      if (inValue!.length == 0) {
                        return "Inserire nome";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.nome = inValue;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Quantità", hintText: "100g"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.quantita,
                    textInputAction: TextInputAction.next,
                    validator: (String? inValue) {
                      if (inValue!.length == 0) {
                        return "Inserire quantità";
                      }
                      return null;
                    },
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.quantita = inValue;
                    },
                  ),
                  TextFormField(
                    key: Key(
                        productModel.prodottoSelezionato!.scadenza.toString()),
                    onTap: () => _selezionaData(context),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Scadenza"),
                    initialValue: productModel.prodottoSelezionato!.scadenza,
                    validator: (String? inValue) {
                      if (inValue!.length == 0) {
                        return "Inserire scadenza";
                      }
                      if (DateTime.parse(
                              productModel.prodottoSelezionato!.scadenza)
                          .isBefore(DateTime.now())) {
                        return "Prodotto già scaduto! Verificare la data inserita";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Marca", hintText: "Kambusa Industries"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.marca,
                    textInputAction: TextInputAction.next,
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.marca = inValue;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: "Prezzo", hintText: "1.30"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.prezzoToString(),
                    textInputAction: TextInputAction.next,
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.prezzo =
                          double.parse(inValue);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "BarCode", hintText: "8012345789"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.barcode,
                    enabled: productModel.prodottoSelezionato!.id == -1
                        ? true
                        : false,
                    textInputAction: TextInputAction.next,
                    onTap: () => scanBarcodeNormal(),
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.barcode = inValue;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //torno a visualizzazione prodotti
                            productModel.setStackIndex(manager.precedente());
                          },
                          child: Text("Annulla"),
                          style: ElevatedButton.styleFrom(
                            primary: secondColor[1],
                          ),
                        ),
                        ElevatedButton(
                            child: Text("Conferma"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _save(context);
                                productModel
                                    .setStackIndex(manager.precedente());
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selezionaData(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateUtils.addDaysToDate(DateTime.now(), 1),
        firstDate: DateUtils.addDaysToDate(DateTime.now(), 1),
        lastDate: DateUtils.addDaysToDate(DateTime.now(), 3650),
        //Builder per mettere testo bianco
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              colorScheme: ColorScheme.light(
                primary: baseColor,
              ),
            ),
            child: child ?? Text(""),
          );
        });
    productModel.prodottoSelezionato!.scadenza =
        DateFormat("yyyy-MM-dd").format(selectedDate!);
    productModel.setStackIndex(1);
  }
}

void _save(context) async {
  if (productModel.prodottoSelezionato!.id == -1) {
    bool snackbar =
        await DBProdotti.dbProdotti.create(productModel.prodottoSelezionato!);
    if (snackbar) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Prodotto ${productModel.prodottoSelezionato!.nome} aggiunto e aggiornato correttamente! 🤙"),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Prodotto aggiunto correttamente! 👌"),
        behavior: SnackBarBehavior.floating,
      ));
    }
    productModel.caricaProdotti(DBProdotti.dbProdotti);
    return;
  }
//qui sto modificando, prima esco per forza!
  print("modifico");
  await DBProdotti.dbProdotti.update(productModel.prodottoSelezionato!);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Prodotto salvato correttamente! 🤟"),
    behavior: SnackBarBehavior.floating,
  ));
  productModel.caricaProdotti(DBProdotti.dbProdotti);
}

Future<void> scanBarcodeNormal() async {
  String barcodeScanRes;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    DBProdotti.dbProdotti.get_from_barcode(barcodeScanRes).then((value) {
      if (productModel.prodottoSelezionato!.barcode != value.barcode) {
        productModel.prodottoSelezionato!.barcode = value.barcode;
      }
      if (productModel.prodottoSelezionato!.nome == "") {
        productModel.prodottoSelezionato!.nome = value.nome;
      }
      if (productModel.prodottoSelezionato!.marca == null ||
          productModel.prodottoSelezionato!.marca == "") {
        productModel.prodottoSelezionato!.marca = value.marca;
      }
      if (productModel.prodottoSelezionato!.prezzoToString() == "") {
        productModel.prodottoSelezionato!.prezzo = value.prezzo;
      }
      if (productModel.prodottoSelezionato!.quantita == "") {
        productModel.prodottoSelezionato!.quantita = value.quantita;
      }
      productModel.setStackIndex(1);
    });
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }
}
