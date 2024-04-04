

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glumate_flutter/core/config.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> patientRegister({required PatientRequest body });
  Future<void> doctorRegister({required DoctorRequest body });
  Future<UserModel> getUser({required String uid});
  Future<UserModel> updateUser({required Map<String, dynamic> updateData});
  Future<Either<Failure, String>> sendActivationCode({required String email}); // New method

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
  
@override
Future<UserModel> updateUser({required Map<String, dynamic> updateData}) async {
  String updateUserURL = "${AppConfig.baseUrl}user/updateProfile";
  try {
    final response = await dio.put(
      updateUserURL,
      data: updateData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return UserModel.fromJson(response.data);
  } on DioError catch (e) {
    if (e.response != null && e.response!.statusCode == 400) {
      print('Invalid user ID: ${e.response!.statusCode}');
      throw ServerFailure(); // Handle 400 error as a server failure
    } else {
      print('Error updating user: ${e.message}');
      throw ServerFailure(); // Handle other errors as server failure
    }
  } catch (e) {
    print(e);
    throw ServerFailure(); // Catch any other unexpected errors as server failure
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

   @override
  Future<Either<Failure, String>> sendActivationCode({required String email}) async {
    String sendActivationCodeURL = "${AppConfig.baseUrl}user/send";
    try {
      final response = await dio.post(
        sendActivationCodeURL,
        data: {'email': email},
      );
      final String resetCode = response.data['resetCode'];
      return Right(resetCode);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        print('User not found: ${e.response!.statusCode}');
        return Left(ServerFailure());
      } else {
        print('Error sending activation code: ${e.message}');
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<void> doctorRegister({required DoctorRequest body}) async {
   const doctorRegisterURL = "${AppConfig.baseUrl}provider/providerRegister" ;
try {
await dio.post ( doctorRegisterURL , data: body.toJson());

} on DioException catch (e){


  if (e.response != null && e.response!.statusCode == 400) {
      print('Email already exists: ${e.response!.statusCode}');
      throw EmailExistsFailure();
    } else {
      print('Error registering provider: ${e.message}');
      throw ServerFailure(); 
    }
}
}}