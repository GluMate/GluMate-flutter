



import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/buisness/entities/gluc_entity.dart';
import 'package:glumate_flutter/buisness/entities/user_entity.dart';
import 'package:glumate_flutter/buisness/repositories/user_repository.dart';
import 'package:glumate_flutter/buisness/usecases/gluc_record.dart';
import 'package:glumate_flutter/buisness/usecases/patient_register.dart';
import 'package:glumate_flutter/buisness/usecases/user_login.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/data/datasources/remote/gluc_remote_data_source.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/gluc_model.dart';
import 'package:glumate_flutter/data/models/user_model.dart';
import 'package:glumate_flutter/data/repositories/gluc_repository_impl.dart';
import 'package:glumate_flutter/data/repositories/user_repository_impl.dart';
import 'package:intl/intl.dart';

class GlucoseProvider extends ChangeNotifier {
  Failure? failure;
  List<GlucEntity>? record ;
  GlucoseProvider({
    this.failure,
    this.record
  
  });
   bool _isLoading = false;
  String _manualRecordErrorMessage = ""; 
    String _fetchRecordErrorMessage = ""; 
  String _unit = "mg/dL";
  double _gluc = 80.0 ;
  int _gluc1 = 80;
  int _maxGluc1 = 399;
  int _minGluc1 = 50;
  int _maxGluc2 = 99;
  int _minGluc2 = 00;
    int _gluc2 = 0;
  String _glucRange = "";
  String _glucHint = "";
var _iconColor = Colors.transparent;
  String _type = "" ;
  int? _Hour  ;
  int? _Minute ;
  int? _Year ;
  int? _Month ;
   int? _Day ;
  double _indicator = 0 ;
  String get unit => _unit;
    String get type => _type;
  int get gluc1 => _gluc1;
  int get gluc2 => _gluc2;
   int get maxluc1 => _maxGluc1;
   int get minluc1 => _minGluc1;
  double get gluc => _gluc;
   String get range => _glucRange;
      String get hint => _glucHint;
    double get indicator => _indicator;
        dynamic get iconColor => _iconColor;
        int? get Hour => _Hour;
        int? get Minute => _Minute;
          int? get Year => _Year;
            int? get Month => _Month;
              int? get Day => _Day;

     String get manualRecordErrorMessage => _manualRecordErrorMessage;
         String get fetchRecordErrorMessage => _fetchRecordErrorMessage;
           bool get isLoading => _isLoading;

  void setUnit(String unit) {
    _setUnit(unit);
  }
    void setType(String type) {
    _setType(type);
  }
    void setGlucHint(String hint) {
    _setGlucHint(hint);
  }
    void setMaxGluc1(int max) {
    _setMaxGlu1(max);
  }
      void setMinGluc1(int min) {
    _setMinGlu1(min);
  }
  void setYear(int year) {
    _setYear(year);
  }
   void setMonth(int month) {
    _setMonth(month);
  }
   void setDay(int day) {
    _setDay(day);
  }

     void setHour(int hour) {
    _setHour(hour);
  }
       void setMinute(int minute) {
    _setMinute(minute);
  }

void setGuc(int gluc1, int gluc2) {
  final glucString = "$gluc1.$gluc2";
  final glucValue = double.tryParse(glucString);
  
    _gluc1 = gluc1;
    _gluc2 = gluc2;
    _gluc = glucValue!; 
    _setGluc(_gluc);   

   
  
}

  void setIndicator(String range , color) {
   _setIndicator(range , color);
  }

      void setManualRecordErrorMessage(String error) {
    _setManualRecordErrorMessage(error);
  }


  void _setManualRecordErrorMessage(String error){
    _manualRecordErrorMessage = error;
    notifyListeners();
  }

     void setFetchRecordErrorMessage(String error) {
    _setFetchRecordErrorMessage(error);
  }


  void _setFetchRecordErrorMessage(String error){
    _fetchRecordErrorMessage = error;
    notifyListeners();
  }
void _setUnit(String unit) {
    _unit = unit;
    notifyListeners();
  }
  void _setType(String type) {
    _type = type;
    notifyListeners();
  }

  void _setGlucHint(String hint) {
    _glucHint = hint;
    notifyListeners();
  }

  void _setMaxGlu1(int max) {
    _maxGluc1 = max;
    notifyListeners();
  }

    void _setMinGlu1(int min) {
    _minGluc1 = min;
    notifyListeners();
  }
  void _setGluc(double gluc) {
    _gluc = gluc;
    notifyListeners();
  }

    void _setIndicator(String range , color) {
    _glucRange = range;
    _iconColor = color;
    switch (range) {
      case("extremely low"):
      _indicator = 0;
      _glucHint = "Low sugar levels detected. Take a moment to address this." ;
      case("low"):
      _indicator = 1;
      _glucHint = "Sugar levels are a bit low. It's good to be aware." ;
       case("normal"):
      _indicator = 2;
      _glucHint = "Your sugar levels are in the healthy range. Keep it up!" ;
       case("high"):
      _indicator = 3;
      _glucHint = "High sugar levels detected. Worth keeping an eye on." ;
       case("extremely high"):
      _indicator = 4;
      _glucHint = "Dangerously high glucose levels. You need an immediate intervention!" ;
    }
    notifyListeners();
  }

void _setYear(int year) {
    _Year = year;
    notifyListeners();
  }

  void _setMonth(int month) {
    _Month = month;
    notifyListeners();
  }
    void _setDay(int day) {
    _Day = day;
    notifyListeners();
  }
      void _setHour(int hour) {
    _Hour = hour;
    notifyListeners();
  }

      void _setMinute(int minute) {
    _Minute = minute;
    notifyListeners();
  }

void checkGlucRange(double gluc, String unit, String type) {
    if (unit == "mmol/L") {
        gluc *= 18.018;
    }

    if (gluc < 40.00) {
        setIndicator("extremely low", Colors.deepOrange);
    } else if (type == "before meal" || type == "before medication" || type == "fasting") {
        if (gluc >= 250) {
            setIndicator("extremely high", Colors.red);
        } else if (gluc >= 100.00) {
            setIndicator("high", Colors.orange);
        } else if (gluc >= 70.00) {
            setIndicator("normal", Colors.green);
        } else if (gluc <= 69.00) {
            setIndicator("low", Colors.yellow);
        }
    } else if (type == "after medication") {
        if (gluc >= 380.00) {
            setIndicator("extremely high", Colors.red);
        } else if (gluc >= 110.00) {
            setIndicator("high", Colors.orange);
        } else if (gluc >= 70.00) {
            setIndicator("normal", Colors.green);
        } else if (gluc <= 69.00) {
            setIndicator("low", Colors.yellow);
        }
    } else if (type == "after meal" || type == "after working") {
        if (gluc >= 250.00) {
            setIndicator("extremely high", Colors.red);
        } else if (gluc >= 140.00) {
            setIndicator("high", Colors.orange);
        } else if (gluc >= 80.00) {
            setIndicator("normal", Colors.green);
        } else if (gluc <= 79.00) {
            setIndicator("low", Colors.yellow);
        }
    }
}

 int StringToint(String x) {
 int value = int.parse(x);

  return value;

 }

 Future<void> eitherFailureOrManualRecord({
    required String note,
    required String unit,
    required double gluc,
    required String userId,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute

  }) async {
    GlucRepositoryImpl repository = GlucRepositoryImpl(
      glucRemoteDataSource: GlucRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

setManualRecordErrorMessage("");
    try {
      String? token = await Auth().currentUser?.getIdToken();
      await GlucRecord(repository).callManualRecord(
        token: token!,
        manuelRequest: ManuelRequest(
          note: note,
          measured_at: DateTime(year, month, day, hour + 1, minute).toString(),
          unit: unit,
          gluc: gluc,
          userId: userId
         
        ),
      );
    }  on NetworkFailure {
      setManualRecordErrorMessage(NetworkFailure().errorMessage);
    } on ServerFailure {
      setManualRecordErrorMessage(ServerFailure().errorMessage);
    } on AppFailure {
       setManualRecordErrorMessage(AppFailure().errorMessage);
    }
  }


Future<void> eitherFailureOrFetchRecords({required String id , required int limit}) async {
  GlucRepositoryImpl repository = GlucRepositoryImpl(
      glucRemoteDataSource: GlucRemoteDataSourceImpl(dio: Dio()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
setFetchRecordErrorMessage("");
_isLoading = true;
    notifyListeners();
     
      String? token = await Auth().currentUser?.getIdToken();
   final records=  await GlucRecord(repository).callFetchRecords(
        token: token!,
        id: id,
        limit: limit
      );
    return records.fold(
      (newFailure) {
        record = [];
        failure = newFailure;
        _isLoading = false;
        notifyListeners();
        return Left(newFailure);
      },
      (records) {
        failure = null;
        record = records;
                  _isLoading = false;
        notifyListeners();
        return Right(records);
      },
    );

}

}