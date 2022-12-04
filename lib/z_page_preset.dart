import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_away/data_storage.dart';
import 'package:flutter_away/weight_collector.dart';

class PresetPage extends StatefulWidget {
  const PresetPage({super.key});

  @override
  State<StatefulWidget> createState() => _PresetPage();
}

class _PresetPage extends State<PresetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preset Page Title'),
        ),
        body: const Text('Preset Page Body'));
  }
}
