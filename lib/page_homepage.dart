import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Functionalities
import 'package:flutter_away/functionalities/data_storage.dart';
import 'package:flutter_away/functionalities/element_factory.dart';
import 'package:flutter_away/functionalities/global_variable.dart';
import 'package:flutter_away/functionalities/weight_collector.dart';

// Pages
import 'package:flutter_away/pages/weight/page_weight_check.dart';
import 'package:flutter_away/pages/weight/page_weight_history.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Away',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomepagePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomepagePage extends StatefulWidget {
  const HomepagePage({super.key, required this.title});

  final String title;

  @override
  State<HomepagePage> createState() => _HomepagePage();
}

class _HomepagePage extends State<HomepagePage> {
  void _goTo(var page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page))
        .then((value) => setState((() {})));
  }

  void goToWeightCheck() => _goTo(const WeightCheck());

  void goToWeightHistory() => _goTo(const WeightHistoryPage());

  void getFileData() async {
    DataStorage storage = DataStorage();
    WeightCollector collector = WeightCollector();
    var entrysOfFile = await storage.readEntrys();
    collector.clearEntryList();
    for (Entry entry in entrysOfFile) {
      collector.addEntryToList(entry);
    }
    if (GlobalVariable.startup) {
      GlobalVariable.startup = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    getFileData();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
            child: Column(children: [
          ElementFactory.homePageCard('Weight Check', goToWeightCheck),
          ElementFactory.homePageCard('Weight History', goToWeightHistory),
        ])));
  }
}
