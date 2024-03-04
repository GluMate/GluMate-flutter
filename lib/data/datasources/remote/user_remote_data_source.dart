

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glumate_flutter/core/config.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> patientRegister({required PatientRequest body });
  Future<UserModel> getUser({required String uid});


}


class UserRemoteDataSourceImpl implements UserRemoteDataSource {
final Dio dio ;

UserRemoteDataSourceImpl({required this.dio});


  @override
Future<void> patientRegister({required PatientRequest body}) async {
const patientRegisterURL = "${AppConfig.baseUrl}user/PatientRegister" ;
try {
await dio.post ( patientRegisterURL , data: body.toJson());

} on DioException catch (e){


  if (e.response != null && e.response!.statusCode == 400) {
      print('Email already exists: ${e.response!.statusCode}');
      throw EmailExistsFailure();
    } else {
      print('Error registering user: ${e.message}');
      throw ServerFailure(); 
    }
}


catch (e){
  
      throw AppFailure();
}

  }

Future<UserModel> getUser({required String uid}) async {
  String getUserURL = "${AppConfig.baseUrl}user/$uid";
  try {
    final response = await dio.get(getUserURL);
    return UserModel.fromJson(response.data);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      throw TimeoutException('Connection timed out');
    } else {
      throw ServerFailure();
    }
  } catch (e) {
    print(e);
    throw ServerFailure();
  }
  
}
}