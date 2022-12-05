import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_away/functionalities/data_storage.dart';
import 'package:flutter_away/functionalities/weight_collector.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<StatefulWidget> createState() => _InputPage();
}

class _InputPage extends State<InputPage> {
  TextEditingController dateController = TextEditingController();
  String date =
      '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
  String weight = "";
  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WeightCollector collector = WeightCollector();

    DateTime stringToDateTime(String date) {
      List<String> arr = date.split('.');
      int year = int.parse(arr[2]);
      int month = int.parse(arr[1]);
      int day = int.parse(arr[0]);
      return DateTime(year, month, day);
    }

    void updateWeight(String value) {
      print('Changing $weight to ${value.replaceAll(',', '.')}');
      weight = value.replaceAll(',', '.');
    }

    void safeEntry(Entry new_entry) {
      collector.addEntryToList(new_entry);
      DataStorage storage = DataStorage();
      storage.writeEntrys();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Entry'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.bar_chart_rounded),
                    labelText: 'current Weight'),
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
                controller: dateController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    labelText: 'current Date'),
                readOnly: true,
                // keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        '${pickedDate.day}.${pickedDate.month}.${pickedDate.year}';

                    setState(() {
                      print('update date: $date --> $formattedDate');
                      dateController.text = formattedDate;
                      date = formattedDate;
                    });
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
                      print('Weight: $weight');
                      print('Date: $date');
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
                      print(e);
                    }
                  },
                  child: const Text('Submitt'))
            ],
          ),
        ));
  }
}
