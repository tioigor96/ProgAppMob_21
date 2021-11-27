//schermata inserimento di un prodotto

import 'package:Kambusapp/DB/DB.dart';
import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddView extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackAppBar(),
      body: SingleChildScrollView(
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
                  onChanged: (String inValue) {
                    productModel.prodottoSelezionato!.nome = inValue;
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Quantità", hintText: "100g"),
                  initialValue: productModel.prodottoSelezionato == null
                      ? null
                      : productModel.prodottoSelezionato!.quantita,
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
                  onTap: () {
                    _selezionaData(context);
                  },
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
                  onChanged: (String inValue) {
                    productModel.prodottoSelezionato!.marca = inValue;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: "Prezzo", hintText: "1.30"),
                  initialValue: productModel.prodottoSelezionato == null
                      ? ""
                      : productModel.prodottoSelezionato!.marca,
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
                          productModel.setStackIndex(0);
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
                              _save();
                              productModel.setStackIndex(0);
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
    );
  }

  Future<void> _selezionaData(BuildContext context) async {
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

void _save() async {
  if (productModel.prodottoSelezionato!.id == -1) {
    await DBProdotti.dbProdotti.create(productModel.prodottoSelezionato!);
  } else {
    print("modifico");
    //await NotesDBworker.notesDBworker.update(notesModel.noteBeingEdited);
  }
  productModel.caricaProdotti(DBProdotti.dbProdotti);
}
