import 'package:glumate_flutter/buisness/repositories/user_repository.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class UserLogin {
  final UserRepository repository;

  UserLogin(this.repository);

  Future<void> callUserLogin({required UserLoginRequest userLoginRequest}) async {
     await repository.userLogin(body: userLoginRequest);
  }


  Future<void> callUserLogout() async {
     await repository.userLogout();
  }
}