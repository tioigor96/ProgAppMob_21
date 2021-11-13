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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getBackAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Nome", hintText: "Pane"),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Quantità", hintText: "100g"),
                ),
                //TODO: da sistemare!!
                /*DateTimeField(
            format: format,
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                    currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },*/
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Marca", hintText: "Kambusa Industries"),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Prezzo", hintText: "1.0 BTC"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "BarCode", hintText: "8012345789"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: Text("Salva"),
                        onPressed: () =>
                            {print("QUI DEVO SALVARE E PRIMA VALIDARE!")}),
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
}
