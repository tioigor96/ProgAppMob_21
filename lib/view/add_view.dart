//schermata inserimento di un prodotto

import 'package:Kambusapp/DB/db.dart';
import 'package:Kambusapp/common/utils.dart';
import 'package:Kambusapp/model/page_manager.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../common/colors.dart';
import 'widget.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

GlobalKey barcodeHint = GlobalKey();

class AddView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<String> descrizione = [
    "Scansiona il barcode per memorizzare il prodotto. Potrai riutilizzarlo in seguito",
    "Scannerizza il barcode se hai già inserito questo prodotto in precedenza"
  ];

  @override
  Widget build(BuildContext context) {
    // print("creo schermata add");
    return Scaffold(
      appBar: ReusableWidget.getBackNoSearchAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nome", hintText: "Pane"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.nome,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
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
                    decoration: const InputDecoration(
                        labelText: "Quantità", hintText: "100g"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.quantita,
                    textInputAction: TextInputAction.next,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
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
                    decoration: const InputDecoration(labelText: "Scadenza"),
                    initialValue: productModel.prodottoSelezionato!.scadenza,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
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
                    decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
                        labelText: "Prezzo", hintText: "1.30"),
                    initialValue: productModel.prodottoSelezionato == null
                        ? null
                        : productModel.prodottoSelezionato!.prezzoToString(),
                    textInputAction: TextInputAction.next,
                    onChanged: (String inValue) {
                      productModel.prodottoSelezionato!.prezzo =
                          double.parse(inValue);
                    },
                  ),
                  Showcase(
                    key: barcodeHint,
                    description: descrizione[(numeroAdd - 1) % 2],
                    //"Scansiona il barcode per memorizzare il prodotto. Potrai riutilizzarlo in seguito",
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.info,
                              color: productModel.prodottoSelezionato!.id == -1
                                  ? baseColor
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              if (productModel.prodottoSelezionato!.id == -1) {
                                _showInfo(context);
                              }
                            },
                          ),
                          labelText: "BarCode",
                          hintText: "8012345789"),
                      controller: TextEditingController(
                        text: productModel.prodottoSelezionato == null
                            ? null
                            : productModel.prodottoSelezionato!.barcode,
                      ),
                      enabled: productModel.prodottoSelezionato!.id == -1
                          ? true
                          : false,
                      textInputAction: TextInputAction.next,
                      onTap: () => scanBarcodeNormal(),
                      onChanged: (String inValue) {
                        productModel.prodottoSelezionato!.barcode = inValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //torno a visualizzazione prodotti
                            productModel.setStackIndex(manager.precedente());
                          },
                          child: const Text("Annulla"),
                          style: ElevatedButton.styleFrom(
                            primary: secondColor[1],
                          ),
                        ),
                        ElevatedButton(
                            child: const Text("Conferma"),
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

  Future<int> getApertura(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? c = prefs.getInt('counter');
    return c!;
  }

  Future<void> _selezionaData(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateUtils.addDaysToDate(DateTime.now(), 1),
        firstDate: DateUtils.addDaysToDate(DateTime.now(), 1),
        lastDate: DateUtils.addDaysToDate(DateTime.now(), 3650),
        //Builder per mettere testo bianco
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              colorScheme: ColorScheme.light(
                primary: baseColor,
              ),
            ),
            child: child ?? const Text(""),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Prodotto aggiunto correttamente! 👌"),
        behavior: SnackBarBehavior.floating,
      ));
    }
    productModel.caricaProdotti(DBProdotti.dbProdotti);
    return;
  }
//qui sto modificando, prima esco per forza!
//   print("modifico");
  await DBProdotti.dbProdotti.update(productModel.prodottoSelezionato!);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

Future<void> _showInfo(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Come usare il barcode?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                'Quando inserisci per la prima volta un prodotto, scansiona il suo codice a barre!',
                textAlign: TextAlign.justify,
              ),
              Text(
                'In seguito, tutte le volte che vorrai inserire lo stesso prodotto, ti basterà inquadrare il barcode e i dati verranno compilati in automatico.',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
