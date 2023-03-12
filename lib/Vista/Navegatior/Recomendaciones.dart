// ignore: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'PopMenu.dart';

class Sensores extends StatefulWidget {
  const Sensores({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SensoresState createState() => _SensoresState();
}

class _SensoresState extends State<Sensores> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Recomendaciones"),
        centerTitle: true,
        backgroundColor: Color(0xFF11253c),
        automaticallyImplyLeading: false,
        actions: [PopMenu().menu(context)],
      ),
      body:panel()
    );
  }
  Widget panel(){
    return Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.temperatura,
                    yValueMapper: (_SalesData sales, _) => sales.humedad,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].temperatura,
                yValueMapper: (int index) => data[index].humedad,
                dataCount: 5,
              ),
            ),
          )
        ]);
  }
}
class _SalesData {
  _SalesData(this.temperatura, this.humedad);

  final String temperatura;
  final double humedad;
}