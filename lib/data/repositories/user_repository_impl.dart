import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glumate_flutter/buisness/repositories/user_repository.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  

  final NetworkInfo networkInfo ;
  final UserRemoteDataSource userRemoteDataSource ;
  
  UserRepositoryImpl({required this.networkInfo , required this.userRemoteDataSource });
  @override
  Future<void> patientRegister({required PatientRequest body}) async{


  if (await networkInfo.isConnected!){
    try{
      await userRemoteDataSource.patientRegister(body: body);
            
     } on EmailExistsFailure {

      throw EmailExistsFailure();
    }
    on ServerFailure {

      throw ServerFailure();

    }  on AppFailure {

      throw AppFailure();

    }
  } else {
      throw NetworkFailure();

  }
  }

@override
  Future<void> userLogin({required UserLoginRequest body }) async {

    if (await networkInfo.isConnected!){
      try{
        await Auth().signInWithEmailAndPassword(email: body.email,
 password: body.password);
  } on FirebaseAuthException catch (e) {
    print('FireBaseAuth Error : ${e.code} ; message : ${e.message}');
    throw FireBaseAuthFailure(errorMessage: e.message!);
    }

  } else {
   throw NetworkFailure();  
  }
    
  } 

  
}