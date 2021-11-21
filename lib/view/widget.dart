//widget riutilizzabili in diverse schermate

import 'package:Kambusapp/assets/constants.dart' as Constants;
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../model/product_model.dart';
import '../common/utils.dart' as utils;

class ReusableWidget {
  //App bar
  static getAppBar() {
    return AppBar(
      title: const Text(Constants.appName,
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              productModel.setStackIndex(2);
              print("2");
            }
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }

  //AppBar con back
  static getBackAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            productModel.setStackIndex(0);
          }),
      title: const Text(Constants.appName,
          style: TextStyle(
              color: Colors.white) //da commentare se voglio titolo nero
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              // do something
            }),
      ],
    );
  }

  static getSearchAppBar()
  {
    return AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              productModel.setStackIndex(0);
            }),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              style: TextStyle(color: Colors.white),            //da commentare se voglio scrivere in nero
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        Icons.search,
                        color: Colors.white
                    ),
                    onPressed: () {
                    },
                  ),
                  hintText: 'Cerca...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none),
            ),
          ),
        ));
  }

 static getExpansionProduct (p)
 {
   return Column(
     children: [ExpansionTile(
       title: getTitle(p),
       subtitle:TextFormField(
         enabled: false,
         initialValue:p.quantita,
         readOnly: true,
         decoration: new InputDecoration(
           border: InputBorder.none,
           labelText: "Quantità",
           labelStyle: TextStyle(
               color: Colors.grey
           ),
           floatingLabelBehavior:FloatingLabelBehavior.always,
         ),
       ),
       children: <Widget>[
         Padding(
           padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
           child: Column(
             children: [TextFormField(
               enabled: false,
               initialValue:p.scadenza,
               readOnly: true,
               decoration: new InputDecoration(
                 border: InputBorder.none,
                 labelText: "Scadenza",
                 labelStyle: TextStyle(
                     color: Colors.grey
                 ),
               ),
             ),
               TextFormField(
                 enabled: false,
                 initialValue:p.marca==null
                     ? " "
                     : p.marca,
                 readOnly: true,
                 decoration: new InputDecoration(
                   border: InputBorder.none,
                   labelText: "Marca",
                   labelStyle: TextStyle(
                       color: Colors.grey
                   ),
                 ),
               ),
               TextFormField(
                 enabled: false,
                 initialValue: p.prezzo==null
                     ? " "
                     : "€ " + p.prezzo.toString(),
                 readOnly: true,
                 decoration: new InputDecoration(
                   border: InputBorder.none,
                   labelText: "Prezzo",
                   labelStyle: TextStyle(
                       color: Colors.grey
                   ),
                 ),
               ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 IconButton(
                     icon: Icon(Icons.edit),
                     onPressed: () {
                       //TODO set stack index per modifica
                     }),
                 IconButton(
                     icon: Icon(Icons.delete),
                     onPressed: () {
                       //TODO eliminare
                     }),
                ],
             )],
           ),
         ),
       ],
     ),],
   );
 }



  static getTitle(Product p)
  {
      if((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <= utils.notificaRossa)
      {
          return Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: thirdColor[700],
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Container(
                width: 10,
              ),
              Text(p.nome.capitalize()),],
          );
      }
      else
      {
        if((DateTime.parse(p.scadenza).difference(DateTime.now()).inDays) + 1 <= utils.notificaGialla)
        {
          return Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: secondColor[600],
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
              ),
              Container(
                width: 10,
              ),
              Text(p.nome.capitalize()),],
          );
        }
        else
        {
            return Text(p.nome.capitalize());
        }
      }
  }


}

