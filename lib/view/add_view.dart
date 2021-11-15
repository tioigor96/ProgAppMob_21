//schermata inserimento di un prodotto

import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddView extends StatefulWidget {
  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _scadenza = null;

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
                  onTap: () {
                    _selezionaData(context);
                  },
                  decoration: InputDecoration(labelText: "Scadenza"),
                  initialValue: _scadenza,
                  validator: (String? inValue) {
                    if (inValue!.length == 0) {
                      return "Inserire scadenza";
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: Text("Salva"),
                        onPressed: () {
                          _formKey.currentState!.validate();
                          print("QUI DEVO SALVARE E PRIMA VALIDARE!");
                        }),
                    ElevatedButton(
                        onPressed: () => {print("QUI DEVO USCIRE")},
                        child: Text("Annulla"))
                  ],
                )
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2032),
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
    setState(() {
      _scadenza = DateFormat("yyyy-MM-dd").format(selectedDate);
      print(
          "passa ${_scadenza}"); //TODO: non segna nel campo con il setState.....
    });
  }
}
