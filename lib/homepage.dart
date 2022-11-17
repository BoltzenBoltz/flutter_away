import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_away/weight_check.dart';

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
  void goToWeightCheck() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WeightCheck()))
        .then((value) => setState((() {})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preset Page Title'),
        ),
        body: Center(
            child: Column(children: [
          InkWell(
            child: const Card(child: Text('Weight Check')),
            onTap: () => goToWeightCheck(),
          ),
          const Card(child: Text('Test'))
        ])));
  }
}
