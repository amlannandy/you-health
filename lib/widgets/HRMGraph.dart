import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/SensorValue.dart';

class HRMGraph extends StatelessWidget {
  final List<SensorValue> _data;

  HRMGraph(this._data);

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      [
        charts.Series<SensorValue, DateTime>(
          id: 'Values',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (SensorValue data, _) => data.time,
          measureFn: (SensorValue data, _) => data.value,
          data: _data,
        )
      ],
      animate: false,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }
}
