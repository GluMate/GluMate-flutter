

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glumate_flutter/core/config.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/gluc_model.dart';
import 'package:intl/intl.dart';


abstract class GlucRemoteDataSource {
  Future<void> manuelRecord({required String token,required ManuelRequest body });
Future<List<GlucModel>> fetchRecords({required String token , required String id , required int limit});
Future<List<RecordModel>> fetchRecordsByTime({required String token , required DateTime start , required DateTime end , String? gran});


}


class GlucRemoteDataSourceImpl implements GlucRemoteDataSource {
final Dio dio ;

GlucRemoteDataSourceImpl({required this.dio});


  @override
Future<void> manuelRecord({required String token,required ManuelRequest body}) async {
const manuelRecordURL = "${AppConfig.baseUrl}glucose/manual" ;
try {
dio.options.headers["Authorization"] = "$token";
await dio.post ( manuelRecordURL , data: body.toJson());

} on DioException catch (e){
print(e);

      throw ServerFailure();
 
}


catch (e){
  print(e);
      throw AppFailure();
}

  }
  
@override
Future<List<GlucModel>> fetchRecords({required String token, required String id , required int limit}) async {
  List<GlucModel> records = [];
  String fetchRecordURL = "${AppConfig.baseUrl}glucose/$id";
  
  try {
    dio.options.headers["Authorization"] = "$token";
    final response = await dio.get(fetchRecordURL);
    print(fetchRecordURL);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data;
      
      // Map the response data to GlucModel objects
      records = responseData.map((data) => GlucModel.fromJson(data)).toList();
      
      // Return only the last 10 records
      return records.length > limit ? records.sublist(records.length - limit) : records;
    } else {
      throw ServerFailure();
    }
  } on DioException catch (e) {
    print(e);
    if (e.response != null && e.response!.statusCode == 500) {
      print('Error in fetching records: ${e.response!.statusCode}');
      throw ServerFailure();
    }
  } catch (e) {
    print(e);
    throw AppFailure();
  }

  throw AppFailure();
}

      @override
      Future<List<RecordModel>> fetchRecordsByTime({required String token, required DateTime start, required DateTime end, String? gran}) async {
    List<RecordModel> records = [];
    String fecthRecordURL = "${AppConfig.baseUrl}glucose/fetch/ByTime/${start}/${end}/${gran}" ;
    try{
      dio.options.headers["Authorization"] = "$token";
    final response = await dio.get(fecthRecordURL);
        if (response.statusCode == 200) {
          final List<dynamic> responseData = response.data;
          records = responseData.map((data) => RecordModel.fromJson(data)).toList();
      return records;
    } else {
      throw ServerFailure();
  }
  
    } on DioException catch (e){
       print(e);

  if (e.response != null && e.response!.statusCode == 500) {
      print('Error in fetching records: ${e.response!.statusCode}');
      throw ServerFailure();
    } 
} catch (e) {
      print(e);
     throw AppFailure() ;
}

throw AppFailure();
    }
   

  }
