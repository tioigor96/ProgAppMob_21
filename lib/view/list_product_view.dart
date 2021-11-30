/*Gestisce lo swipe sx e dx per modificare ed eliminare Richiama la visualizzazione getExpansionProduct3 dal widget.
Per cambiare tipo di visualizzazione richiamare un expansionProduct diverso
 */

//TODO implementare bottoni per eliminazione (aggiungendo il codice in widget)

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Kambusapp/model/product_model.dart';
import '../common/utils.dart' as utils;
import '../common/colors.dart';
import 'widget.dart';

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  ListProductState createState() {
    return ListProductState();
  }
}

class ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: productModel.listaProdotti.length,
      itemBuilder: (context, index) {
        Product p = productModel.listaProdotti[index];
        return Dismissible(
          key: Key(p.id.toString()),
          //direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            setState(() {
              //TODO eliminare da lista e da DB
              //p.items.removeAt(index);
            });

            // Then show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(p.nome.capitalize() + " eliminato")));
          },
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              return true;
            } else if (direction == DismissDirection.endToStart) {
              //modifico
              productModel.prodottoSelezionato = p;
              productModel.setStackIndex(1);
              return false;
            }
          },
          // Show a red background as the item is swiped away.
          background: Container(
            alignment: Alignment.centerLeft,
            color: thirdColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Icon(Icons.delete, color: Colors.white)),
                Text("Elimina",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Colors.white) //da commentare se voglio titolo nero
                    ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: secondColor,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Modifica",
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            Colors.white) //da commentare se voglio titolo nero
                    ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ),
          child: ReusableWidget.getExpansionProduct3(p),
        );
      },
    );
  }
}
