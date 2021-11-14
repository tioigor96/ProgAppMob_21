//schermata inserimento di un prodotto

import 'package:appmobile/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';

class AddView extends StatelessWidget {
  // final format = DateFormat("yyyy-MM-dd");

  GlobalKey<FormState> _formKey = new GlobalKey();


  //i dati inseriti nei form vengono momentaneamente salvati in productModel.prodottoSelezionato
  //TODO salvare in DB
  //TODO aggiornare stato dopo apertura calendar per inserire data in input field
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
                  initialValue: productModel.prodottoSelezionato == null ? null : productModel.prodottoSelezionato!.nome,
                  validator: (String? inValue){
                       if(inValue!.length == 0){
                          return "Inserire nome";
                       }
                       return null;
                    },
                  onChanged: (String inValue){
                    productModel.prodottoSelezionato!.nome = inValue;
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Quantità", hintText: "100g"),
                  initialValue: productModel.prodottoSelezionato == null ? null : productModel.prodottoSelezionato!.quantita,
                  validator: (String? inValue){
                    if(inValue!.length == 0){
                      return "Inserire quantità";
                    }
                    return null;
                  },
                  onChanged: (String inValue){
                    productModel.prodottoSelezionato!.quantita = inValue;
                  },
                ),

                TextFormField(
                  onTap: () { _selezionaData(context).then((value) => productModel.prodottoSelezionato!.scadenza=value);},
                  decoration:
                  InputDecoration(labelText: "Scadenza"),
                  initialValue: productModel.prodottoSelezionato == null ? null : productModel.prodottoSelezionato!.scadenza,
                  validator: (String? inValue){
                    if(inValue!.length == 0){
                      return "Inserire scadenza";
                    }
                    return null;
                  },

                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Marca", hintText: "Kambusa Industries"),
                  initialValue: productModel.prodottoSelezionato == null ? null : productModel.prodottoSelezionato!.marca,
                  onChanged: (String inValue){
                    productModel.prodottoSelezionato!.marca = inValue;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: "Prezzo", hintText: "1.30"),
                  initialValue: productModel.prodottoSelezionato == null ? "" : productModel.prodottoSelezionato!.marca,
                  onChanged: (String inValue){
                    productModel.prodottoSelezionato!.prezzo = double.parse(inValue);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "BarCode", hintText: "8012345789"),
                  initialValue: productModel.prodottoSelezionato == null ? null : productModel.prodottoSelezionato!.barcode,
                  onChanged: (String inValue){
                    productModel.prodottoSelezionato!.barcode = inValue;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: Text("Salva"),
                        onPressed: ()
                            { _formKey.currentState!.validate();
                              print("QUI DEVO SALVARE E PRIMA VALIDARE!");}),
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




  Future<String> _selezionaData(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2032),
      //Builder per mettere testo bianco
      builder: (BuildContext context, Widget ?child) {
          return Theme(
            data: ThemeData(
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              colorScheme: ColorScheme.light(
                  primary: baseColor,
              ),
            ),
            child: child ??Text(""),
          );
        }
    );
    return selectedDate.toString();
  }


}


