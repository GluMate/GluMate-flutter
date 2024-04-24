


import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';


class GlucModel  extends GlucEntity{
  const GlucModel({
    required String id,
    required String measured_at,
     required num gluc,
  required metaDataModel metaData,
  String? date
  }) : super(
          id: id,
          measured_at: measured_at,
          gluc: gluc,
          metaData: metaData,
          date: date
        );

  factory GlucModel.fromJson(Map<String, dynamic> json) {
       final V = json['__v'];
    return GlucModel(
      id: json['_id'],
      measured_at: json['measured_at'],
      date: json['date'],
      gluc: (json['gluc'] as num).toDouble(),
metaData: metaDataModel.fromJson(json['metadata'])      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'measured_at': measured_at,
      '_id': id ,
      'gluc' : gluc ,
    };
  }

}

class RecordModel extends RecordEntity {
  const RecordModel({
    required String date,
    required num gluc
  }) : super(
    date:date,
    gluc: gluc
  ) ;

  factory RecordModel.fromJson(Map<String, dynamic> json) {
       final V = json['__v'];
    return RecordModel(
      date: json['date'],
      gluc: (json['gluc'] as num).toDouble(),   
    );
  }
}
class ManuelRequest {
final  String measured_at ;
final num gluc ;
final String userId;
final String note;
final String unit;

const ManuelRequest({
      required this.measured_at,
      required this.gluc ,
      required this.userId ,
      required this.note , 
      required this.unit
  });
  

  Map<String, dynamic> toJson() {
    return {
      'measured_at': measured_at,
      'gluc': gluc,
      'userId': userId,
      'note': note,
      'unit': unit
    };
  }
}


class metaDataModel extends meatDataEntity {
  const metaDataModel({
    required String userId,
    required String note,
    required String type,
    required String unit,
  }) : super(userId: userId , note:note , type:type , unit:unit);

  static metaDataModel fromJson(Map<String, dynamic> json) {
    return metaDataModel(
     userId: json['userId'],
      note: json['note'],
       type: json['type'],
        unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'note': note,
      'type': type,
      'unit': unit,
    };
  }
}
  
