


class GlucEntity {
 final String id;
   final String measured_at;
    final num gluc;
    final meatDataEntity metaData;
    final String? date;
  const GlucEntity({
    required this.id,
    required this.gluc,
    required this.measured_at,
    required this.metaData,
    this.date
  });
}


class RecordEntity {
   final String date;
   final num gluc;
    const RecordEntity({
    required this.date,
    required this.gluc,
  
  });

}
class meatDataEntity {
  final String userId;
   final String note;
    final String type;
     final String unit;
  const meatDataEntity({
    required this.userId,
     required this.note,
      required this.type,
       required this.unit,
  });
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}

List<ChartData> convertToChartDataList(List<RecordEntity> glucEntities) {
  List<ChartData> chartDataList = [];
  for (var entity in glucEntities) {
    DateTime measuredAt = DateTime.parse(entity.date);
    double gluc = entity.gluc.toDouble(); 
    chartDataList.add(ChartData(measuredAt, gluc));
  }
  return chartDataList;
}

