
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/buisness/usecases/gluc_record.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';

import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/data/datasources/remote/gluc_remote_data_source.dart';
import 'package:glumate_flutter/data/repositories/gluc_repository_impl.dart';


class ChartsProvider extends ChangeNotifier {
  Failure? failure;
  List<ChartData>? record ;
  ChartsProvider({
    this.failure,
    this.record
  
  });
    bool _isLoading = false;

    String _gran = "daily";

 String _fetchRecordErrorMessage = ""; 


String get fetchRecordErrorMessage => _fetchRecordErrorMessage;
bool get isLoading => _isLoading;
String get gran => _gran;




     void setFetchRecordErrorMessage(String error) {
    _setFetchRecordErrorMessage(error);
  }


  void _setFetchRecordErrorMessage(String error){
    _fetchRecordErrorMessage = error;
    notifyListeners();
  }

 void setGran(String gran){
 _setGran(gran);
  }
  void _setGran(String gran){
    _gran = gran;
    notifyListeners();
  }


 Future<void> eitherFailureOrFetchRecords() async {
  GlucRepositoryImpl repository = GlucRepositoryImpl(
      glucRemoteDataSource: GlucRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
setFetchRecordErrorMessage("");
_isLoading = true;
    notifyListeners();
     
      String? token = await Auth().currentUser?.getIdToken();
   final records=  await GlucRecord(repository).callFetchRecordsByTime(
        token: token!,
        end: DateTime.now(),
        start: DateTime.now().subtract(Duration(days: 90)),
        gran: gran

      );
    return records.fold(
      (newFailure) {
        record = [];
        failure = newFailure;
        _isLoading = false;
        notifyListeners();
        print("failure");
        return Left(newFailure);
      },
      (records) {
        failure = null;
        record = convertToChartDataList(records);
                  _isLoading = false;
        notifyListeners();
        print("success");
        return Right(records);
      },
    );

}

}


