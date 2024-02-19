

import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/patient_register_form2_widget.dart';
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

    final int _selectedGender = 1;
    final DateTime _selectedDate = DateTime.now();


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
            onNextPressed: () {
              setState(() {
                _currentPageIndex = 1;
              });
            },
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => RegisterForm2(
            controllerEmail: _controllerEmail,
            controllerPassword: _controllerpassword,
            onFinish: ()  {
             registerProvider.eitherFailureOrRagister(
              firstName: _controllerName ,
               lastName : _controllerLastName ,
                email : _controllerEmail ,
                 password : _controllerpassword , 
                 selectedgender : _selectedGender ,
                  selectedDate : _selectedDate).then((_)  {
                    final errorMessage = registerProvider.errorRegisterMessage;
        if (errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Success")),
          );
        }
                  });
                
            },
             onBack: () {
              setState(() {
                _currentPageIndex = 0;
              });
            },
      )
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
}