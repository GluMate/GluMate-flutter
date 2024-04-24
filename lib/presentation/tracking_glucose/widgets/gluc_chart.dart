import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_charts_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class glucLineChart extends StatefulWidget {
  @override
  State<glucLineChart> createState() => _glucLineChartState();
}

class _glucLineChartState extends State<glucLineChart> {
  late TooltipBehavior _tooltipBehavior;
  DateTimeIntervalType selectedDateType = DateTimeIntervalType.days; // Default selection

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
        Provider.of<ChartsProvider>(context, listen: false).setGran("daily");

    setState(() {
      selectedDateType = DateTimeIntervalType.days;
    });
     Provider.of<ChartsProvider>(context, listen: false).eitherFailureOrFetchRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => changeAxis(DateTimeIntervalType.hours, "hourly"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDateType == DateTimeIntervalType.hours ? TColor.primaryColor1 : TColor.lightGray,
                ),
                child: const Text('hours'),
              ),
              ElevatedButton(
                onPressed: () => changeAxis(DateTimeIntervalType.days, "daily"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDateType == DateTimeIntervalType.days ? TColor.primaryColor1 : TColor.lightGray,
                ),
                child: const Text('days'),
              ),
              ElevatedButton(
                onPressed: () => changeAxis(DateTimeIntervalType.months, "monthly"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDateType == DateTimeIntervalType.months ? TColor.primaryColor1 : TColor.lightGray,
                ),
                child: const Text('months'),
              ),
              ElevatedButton(
                onPressed: () => changeAxis(DateTimeIntervalType.years, "yearly"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedDateType == DateTimeIntervalType.years ? TColor.primaryColor1 : TColor.lightGray,
                ),
                child: const Text('years'),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          final provider = Provider.of<ChartsProvider>(context);
          return provider.isLoading
              ? CircularProgressIndicator() // Show loading indicator
              : SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: DateTimeAxis(
                    intervalType: provider.gran == "hourly"
                        ? DateTimeIntervalType.hours
                        :provider.gran == "monthly"
                           ? DateTimeIntervalType.months
                           : DateTimeIntervalType.days, // Set interval type based on gran
                    autoScrollingDelta: 15,
                    autoScrollingMode: AutoScrollingMode.start,
                    majorGridLines: const MajorGridLines(width: 0)
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                  ),
                  series:  <CartesianSeries<ChartData, DateTime>>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: provider.record ?? [],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                    )
                  ],
                );
        }),
      ],
    );
  }

  void changeAxis(DateTimeIntervalType type, String gran) {
    Provider.of<ChartsProvider>(context, listen: false).setGran(gran);
    Provider.of<ChartsProvider>(context, listen: false).eitherFailureOrFetchRecords();
    setState(() {
      selectedDateType = type;
    });
  }
}
