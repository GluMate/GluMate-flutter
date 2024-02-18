

import 'package:glumate_flutter/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> patientRegister({required PatientRequest body});
   Future<void> userLogin({required UserLoginRequest body});
}