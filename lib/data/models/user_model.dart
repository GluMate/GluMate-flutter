

import 'package:glumate_flutter/buisness/entities/user_entity.dart';

class UserModel  extends UserEntity{
  const UserModel({
    required String id,
    required String email,
     required String firstName,
     required String lastName,
     required String pic,
     required String role,
     String? gender,
      String? dateOfBirth,
    List<dynamic>? providers,

  required String UID
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
           pic: pic,
            role: role,
             gender: gender,
         
               dateOfBirth: dateOfBirth,

              providers: providers,
            
                  UID: UID,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
     final t = json['__t'];
       final V = json['__v'];
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      pic: json['pic'],
      role: json['role'],
      gender: json['Gender'],
  
       dateOfBirth: json['dateOfBirth'],
       providers: json['Providers'],
       UID: json['UID'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      '_id': id ,
      'lastName' : lastName ,
      'email' : email,
      'pic' : pic ,
      'role' : role ,
      'Gender' : gender,
      'dateOfBirth' : dateOfBirth,
      'Providers' : providers,
      'UID' : UID

    };
  }

}


class PatientRequest {
final String firstName ;
final String lastName ;
final String email;
final String password;
final String gender;
final String dateOfBirth;

const PatientRequest({
      required this.firstName,
      required this.email ,
      required this.lastName ,
      required this.password , 
      required this.gender ,
      required this.dateOfBirth
  });
  

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }
}
class DoctorRequest {
  final String title;
  final String bio;
  final String clinicHours;
  final String address; 
  final bool isVerified;
  final String verificationDocument;
  final String specialization;
  final String licenseNumber;

  const DoctorRequest({
    required this.title,
    required this.bio,
    required this.clinicHours,
    required this.address,
    required this.isVerified,
    required this.verificationDocument,
    required this.specialization,
    required this.licenseNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'bio': bio,
      'clinicHours': clinicHours,
      'address': address,
      'isVerified': isVerified,
      'verificationDocument': verificationDocument,
      'specialization': specialization,
      'licenseNumber': licenseNumber,
    };
  }
}
class UserLoginRequest{
  final String email ;
  final String password ;

  const UserLoginRequest({
    required this.email , required this.password
  });

  
}