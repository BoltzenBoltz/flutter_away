import 'dart:async';
import 'dart:io';

import 'package:flutter_away/functionalities/weight_collector.dart';
import 'package:path_provider/path_provider.dart';

class DataStorage {
  static final DataStorage _instance = DataStorage._internal();

  factory DataStorage() => _instance;

  DataStorage._internal();

  get _weightFileName {
    return "flutter_away_weights.txt";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_weightFileName');
  }

  Future<File> writeEntrys() async {
    final file = await _localFile;

    WeightCollector collector = WeightCollector();
    // Entry entry =
    //     collector.getEntryAtIndex(collector.getEntryList().length - 1);

    // Write the file
    return file.writeAsString(collector.toString());
  }

  Future<List<Entry>> readEntrys() async {
    try {
      final file = await _localFile;
      List<Entry> saved_entrys = [];
      // Read the file
      final contents = await file.readAsString();
      List<String> informations = contents.split(';');
      // for (String information in informations) {
      for (int i = 0; i < informations.length; i++) {
        String information = informations[i];
        if (i != informations.length - 1) {
          List<String> info = information.split('-');
          double weight = double.parse(info[0].split(':')[1]);
          List<String> date_list = info[1].split(':')[1].split('.');
          DateTime date = DateTime(int.parse(date_list[2]),
              int.parse(date_list[1]), int.parse(date_list[0]));
          saved_entrys.add(Entry(weight, date));
        }
      }
      return saved_entrys;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<void> clearFile() async {
    final file = await _localFile;
    file.writeAsString('');
    WeightCollector collector = WeightCollector();
    collector.clearEntryList();
  }
}
