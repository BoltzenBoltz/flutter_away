import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_away/data_storage.dart';
import 'package:flutter_away/weight_collector.dart';

class InputRoute extends StatelessWidget {
  const InputRoute({super.key});

  @override
  Widget build(BuildContext context) {
    String weight = "";
    DateTime now = DateTime.now();
    String date = '${now.day}.${now.month}.${now.year}';
    WeightCollector collector = WeightCollector();

    DateTime stringToDateTime(String date) {
      List<String> arr = date.split('.');
      int year = int.parse(arr[2]);
      int month = int.parse(arr[1]);
      int day = int.parse(arr[0]);
      return DateTime(year, month, day);
    }

    void updateWeight(String value) {
      value = value.replaceAll(',', '.');
      weight = value;
    }

    void updateDate(DateTime newDate) {
      date = '${newDate.day}.${newDate.month}.${newDate.year}';
    }

    void safeEntry(Entry new_entry) {
      collector.addEntryToList(new_entry);
      DataStorage storage = DataStorage();
      storage.writeEntrys();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Route'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'current Weight'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'([0-9]{1,3})[,|.]{0,1}([0-9]{0,2})')),
                  LengthLimitingTextInputFormatter(6)
                ],
                onChanged: (value) => updateWeight(value),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                controller: TextEditingController(text: date),
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    labelText: 'current Date'),
                // keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    print(pickedDate);

                    // now = pickedDate;
                    updateDate(pickedDate);
                    print('📅 Date $date');
                  } else {
                    print('Date is not selected');
                  }
                },
                // onChanged: (value) => date = value,
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              ElevatedButton(
                  onPressed: () {
                    try {
                      double dWeight = double.parse(weight);
                      DateTime correctDate = stringToDateTime(date);
                      Entry entry = Entry(dWeight, correctDate);
                      safeEntry(entry);
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid Weight or Date!'),
                        duration: Duration(seconds: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  child: const Text('Submitt'))
            ],
          ),
        ));
  }
}
