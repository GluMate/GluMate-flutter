import 'package:glumate_flutter/buisness/repositories/user_repository.dart';
import 'package:glumate_flutter/data/models/user_model.dart';

class PatientRegister {
  final UserRepository repository;

  PatientRegister(this.repository);

  Future<void> callPatientRegister({required PatientRequest patientRegisterRequest}) async {
     await repository.patientRegister(body: patientRegisterRequest);
  }
}