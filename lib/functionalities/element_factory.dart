import 'package:flutter/material.dart';
import 'package:flutter_away/functionalities/weight_collector.dart';

class ElementFactory {
  /// creates a [Card] in a [FractionallySizedBox] of the current Entry maintopic ([cardName])
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

  /// creates a [Card] in a [FractionallySizedBox] of the current Entry [entry]
  static Widget weightCheckCard(Entry entry) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.left,
                ),
                Text(
                  entry.dateToString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.all(5))
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Weight:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                '${entry.getWeight()}kg',
                style: const TextStyle(fontSize: 16),
              ),
              const Padding(padding: EdgeInsets.all(5))
            ]),
          ],
        )));
  }
}
