



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
    required this.firstName, required this.email , required this.lastName , required this.password , required this.gender ,required this.dateOfBirth
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

class UserLoginRequest{
  final String email ;
  final String password ;

  const UserLoginRequest({
    required this.email , required this.password
  });

  
}