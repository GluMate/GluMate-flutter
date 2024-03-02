import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form2_widget.dart';
import 'package:provider/provider.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({Key? key}) : super(key: key);

  @override
  State<RegisterPatientPage> createState() => _registerPatientPageState();
}

class _registerPatientPageState extends State<RegisterPatientPage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
   int _selectedGender = 1;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false; 

      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? registerForm1(
            controllerName: _controllerName,
            controllerLastName: _controllerLastName,
            selectedGender: _selectedGender,
            selectedDate: _selectedDate,
            onNextPressed: (selectedGender,selectedDate) {
              setState(() {
                _currentPageIndex = 1;
                    _selectedGender = selectedGender;
                    _selectedDate = selectedDate;

              });
            },
          ) 
          :  AbsorbPointer(
            absorbing: _isLoading,
            child: Opacity(
              opacity: _isLoading ? 0.5 : 1.0,
              child: Consumer<RegisterAuthProvider>(
                    builder: (context, registerProvider, _) => RegisterForm2(
                controllerEmail: _controllerEmail,
                controllerPassword: _controllerpassword,
                onFinish: ()  {
                    setState(() {
                          _isLoading = true; // Set isLoading to true when login button is pressed
                        });
                 registerProvider.eitherFailureOrRegister(
                  firstName: _controllerName ,
                   lastName : _controllerLastName ,
                    email : _controllerEmail ,
                     password : _controllerpassword , 
                     selectedgender : _selectedGender ,
                      selectedDate : _selectedDate).then((_)  {
                        setState(() {
                          _isLoading = false; // Set isLoading to true when login button is pressed
                        });   
                      if (registerProvider.errorRegisterMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(registerProvider.errorRegisterMessage)),
              );
                      } else {
                       showSuccessNotification(context, "Success");
              
                      }
                      });
                    
                },
                 onBack: () {
                  setState(() {
                    _currentPageIndex = 0;
                  });
                },
                    )
              ),
            ),
          );
       return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalization.of(context).translate('join_patients')!),
      ),
      body: currentPage
       );
      }
       );

  }
  
void showSuccessNotification(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Success"),
        content: Text(
          AppLocalization.of(context).translate('account')!,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );


}}