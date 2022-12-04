import 'package:flutter/material.dart';

class ElementFactory {
  static Widget homePageCard(String cardName, Function func) {
    Widget homeCard = FractionallySizedBox(
        widthFactor: 0.8,
        child: InkWell(
          child: Card(
              child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(5)),
              Text(cardName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
              const Padding(padding: EdgeInsets.all(5)),
            ],
          )),
          onTap: () => func(),
        ));

    return homeCard;
  }
}
