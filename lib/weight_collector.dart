import 'package:flutter/material.dart';

class WeightCollector {
  static final WeightCollector _instance = WeightCollector._internal();

  final List<Entry> _entrys = [];

  factory WeightCollector() => _instance;

  WeightCollector._internal();

  Entry getEntryAtIndex(int index) => _entrys[index];

  List<Entry> getEntryList() => _entrys;

  void addEntryToList(Entry entry) {
    _entrys.add(entry);
    _sortList();
  }

  void _sortList() {
    _entrys.sort(((a, b) => a.date.compareTo(b.date)));
  }

  void clearEntryList() => _entrys.clear();

  int listLength() => _entrys.length;

  void fillListWithTestData() => {
        for (int i = 0; i < 10; i++)
          {addEntryToList(Entry((100.0 + i), DateTime(2022, 10, 21)))}
      };

  List<Widget> getWeightWidgets() {
    List<Widget> list = [];
    DateTime curDate;
    if (_entrys.isNotEmpty) {
      curDate = _entrys[0].getDate();
    } else {
      curDate = DateTime(2000, 1, 1);
    }
    for (int i = 0; i < _entrys.length; i++) {
      Entry curEntry = _entrys[i];

      // Adding Month-Year-Display
      if (isMonthWidget(curDate, curEntry.getDate(), list.isEmpty)) {
        curDate = curEntry.date;
        list.add(const Padding(padding: EdgeInsets.only(top: 10)));
        list.add(getMonthWidget(curEntry));
      }
      String date =
          '${curEntry.getDate().day}.${curEntry.getDate().month}.${curEntry.getDate().year}';
      list.add(FractionallySizedBox(
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
                    date,
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
                  '${curEntry.getWeight()}kg',
                  style: const TextStyle(fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.all(5))
              ]),
            ],
          ))));
    }
    return list;
  }

  Widget getMonthWidget(Entry entry) {
    List<String> months = [
      "January",
      "Febuary",
      "March",
      "April",
      "Mai",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return Text('${months[entry.getDate().month - 1]} ${entry.getDate().year}');
  }

  bool isMonthWidget(DateTime curDate, DateTime entryDate, bool isListEmpty) {
    if (curDate.month < entryDate.month && curDate.year <= entryDate.year) {
      return true;
    } else if (isListEmpty) {
      return true;
    } else if (curDate.year < entryDate.year) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    String res = '';
    for (Entry entry in _entrys) {
      res += entry.toString();
    }
    return res;
  }
}

class Entry {
  double weight;
  DateTime date;

  Entry(this.weight, this.date);

  double getWeight() => weight;

  DateTime getDate() => date;

  @override
  String toString() => 'w:$weight-d:${date.day}.${date.month}.${date.year};';
}
