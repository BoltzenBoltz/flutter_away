import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_away/data_storage.dart';
import 'package:flutter_away/weight_collector.dart';

// Charts
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class WeightHistoryPage extends StatefulWidget {
  const WeightHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeightHistoryPage();
}

class _WeightHistoryPage extends State<WeightHistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<_TestData> data = [
      _TestData('Jan', 35),
      _TestData('Feb', 28),
      _TestData('Mar', 34),
      _TestData('Apr', 32),
      _TestData('May', 40)
    ];

    WeightCollector collector = WeightCollector();
    List<Entry> weightData = collector.getEntryList();
    print(weightData);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Weight History'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Weight Analysis'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Entry, String>>[
                LineSeries<Entry, String>(
                    dataSource: weightData,
                    xValueMapper: (Entry entrys, _) => entrys.dateToString(),
                    yValueMapper: (Entry entrys, _) => entrys.weight,
                    name: 'Weight',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ])
        ]));
  }
}

class _TestData {
  _TestData(this.year, this.count);

  final String year;
  final int count;
}
