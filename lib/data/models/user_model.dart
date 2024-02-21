



class UserModel {
  

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