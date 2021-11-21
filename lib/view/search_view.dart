//ricerca

import 'package:Kambusapp/model/product_model.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import 'widget.dart';
import 'package:getwidget/getwidget.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidget.getSearchAppBar(),
        body: Column(
            children: [Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: baseColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GFButton(
                        color: Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Nome",
                        textColor: Colors.black,
                        onPressed: () {
                        }),
                    GFButton(
                        color: Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Quantità",
                        textColor: Colors.black,
                        onPressed: () {
                        }),
                    GFButton(
                        color: Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Scadenza",
                        textColor: Colors.black,
                        onPressed: () {
                        }),
                    GFButton(
                        color: Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Marca",
                        textColor: Colors.black,
                        onPressed: () {
                        }),
                  ],
                ),

            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: baseColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GFButton(
                        color: Colors.white,
                        shape: GFButtonShape.pills,
                        size: GFSize.SMALL,
                        text: "Prezzo",
                        textColor: Colors.black,
                        onPressed: () {
                        }),
                    ],
                 ),
              )],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productModel.setStackIndex(1);
        },
        backgroundColor: secondColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
