import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_away/data_storage.dart';
import 'package:flutter_away/page_weight_input.dart';
import 'package:flutter_away/z_page_preset.dart';
import 'package:flutter_away/page_homepage.dart';
import 'package:flutter_away/weight_collector.dart';

void main() {
  runApp(const Homepage());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Away',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataStorage storage = DataStorage();
  WeightCollector collector = WeightCollector();
  bool startup = false;

  void onActionPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InputPage(),
        )).then((value) => setState(() {}));
  }

  void goToPresetPage() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PresetPage()))
        .then((value) => setState((() {})));
  }

  void getFileData() async {
    var entrysOfFile = await storage.readEntrys();
    collector.clearEntryList();
    for (Entry entry in entrysOfFile) {
      collector.addEntryToList(entry);
    }
    if (!startup) {
      startup = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getFileData();
    List<Widget> c = collector.getWeightWidgets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Check'),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: c,
        ),
        // ElevatedButton(onPressed: _addWeight, child: const Text("Add Text"))
      ]))),

/*
  _____                              
 |  __ \                             
 | |  | |_ __ __ ___      _____ _ __ 
 | |  | | '__/ _` \ \ /\ / / _ \ '__|
 | |__| | | | (_| |\ V  V /  __/ |   
 |_____/|_|  \__,_| \_/\_/ \___|_|   
*/

      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Optionen')),
          ListTile(
            title: const Text('Einstellungen'),
            onTap: () {
              // close drawer
              Navigator.pop(context);
              // navigate to Settings-Page
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const InputPage())));
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Refresh'),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('Debug Informations'),
            onTap: () {
              WeightCollector collector = WeightCollector();
              int listLength = collector.listLength();
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: const Text('Delete All Entrys'),
              onTap: () {
                setState(() {
                  storage.clearFile();
                  Navigator.pop(context);
                });
              }),
          ListTile(
              title: const Text('show Preset Page'),
              onTap: () => goToPresetPage())
        ],
      )),

/*
               _   _               ____        _   _              
     /\       | | (_)             |  _ \      | | | |             
    /  \   ___| |_ _  ___  _ __   | |_) |_   _| |_| |_ ___  _ __  
   / /\ \ / __| __| |/ _ \| '_ \  |  _ <| | | | __| __/ _ \| '_ \ 
  / ____ \ (__| |_| | (_) | | | | | |_) | |_| | |_| || (_) | | | |
 /_/    \_\___|\__|_|\___/|_| |_| |____/ \__,_|\__|\__\___/|_| |_|
*/

      floatingActionButton: FloatingActionButton(
        onPressed: onActionPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
