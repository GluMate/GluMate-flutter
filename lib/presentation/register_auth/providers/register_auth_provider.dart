

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/buisness/usecases/patient_register.dart';
import 'package:glumate_flutter/buisness/usecases/user_login.dart';
import 'package:glumate_flutter/core/connection/networ_info.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/data/datasources/remote/user_remote_data_source.dart';
import 'package:glumate_flutter/data/models/user_model.dart';
import 'package:glumate_flutter/data/repositories/user_repository_impl.dart';
import 'package:intl/intl.dart';

class RegisterAuthProvider extends ChangeNotifier {

  Failure? failure;
  RegisterAuthProvider( {
    this.failure
  });
  String _errorRegisterMessage = "";
  String _errorLoginMessage = "" ;
  String get errorRegisterMessage => _errorRegisterMessage;
    String get errorLoginMessage => _errorLoginMessage;

    void setRegisterErrorMessage(String newError) {
    _setErrorRegisterMessage(newError);
  }

     void setLoginErrorMessage(String newError) {
    _setErrorLoginMessage(newError);
  }

  void _setErrorRegisterMessage(String newError) {
    _errorRegisterMessage = newError;
    notifyListeners();
  }
   void _setErrorLoginMessage(String newError) {
    _errorLoginMessage = newError;
    notifyListeners();
  }

 Future<void> eitherFailureOrRagister({
    required TextEditingController firstName,  required TextEditingController lastName,required TextEditingController email, required TextEditingController password, required int selectedgender, required DateTime selectedDate ,

  }) async {
    
    UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

  final String gender = selectedgender == 1 ? 'male' : 'female';
  final String dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);

try {
    await PatientRegister(repository).callPatientRegister(patientRegisterRequest: 
    PatientRequest(
      firstName: firstName.text 
      , email: email.text, 
      lastName: lastName.text,
       password: password.text,
        gender: gender , 
        dateOfBirth :dateOfBirth));

} on EmailExistsFailure {
    setRegisterErrorMessage(EmailExistsFailure().errorMessage);
  } on NetworkFailure {
    setRegisterErrorMessage(NetworkFailure().errorMessage);
  } on ServerFailure {
    setRegisterErrorMessage(ServerFailure().errorMessage);
  } on AppFailure {
    setRegisterErrorMessage(AppFailure().errorMessage);
  }
  }

  
 Future<void> eitherFailureOrLogin({
  required TextEditingController email , required TextEditingController passsword 
}) async {
     UserRepositoryImpl repository = UserRepositoryImpl(
      userRemoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
try {
await UserLogin(repository).callUserLogin(userLoginRequest: UserLoginRequest(email: email.text, password: passsword.text ));
}on FireBaseAuthFailure {

    setLoginErrorMessage(FireBaseAuthFailure(errorMessage: "errorMessage").errorMessage);

} on NetworkFailure {

    setLoginErrorMessage(NetworkFailure().errorMessage);

} on ServerFailure {

    setLoginErrorMessage(ServerFailure().errorMessage);

} on AppFailure {

    setLoginErrorMessage(AppFailure().errorMessage);
}

}
}
