import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/EditProfile.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form2_widget.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
   int _selectedGender = 1;
  DateTime _selectedDate = DateTime.now();


      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? EditProfile(
            controllerName: _controllerName,
            controllerEmail: _controllerEmail,
            controllerLastName: _controllerLastName,
            selectedDate: _selectedDate,
            onNextPressed: (selectedGender,selectedDate) {
              setState(() {
                _currentPageIndex = 1;
                    _selectedGender = selectedGender;
                    _selectedDate = selectedDate;

              });
            },
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => RegisterForm2(
            controllerEmail: _controllerEmail,
            controllerPassword: _controllerpassword,
            onFinish: ()  {
    
             registerProvider.eitherFailureOrRegister(
              firstName: _controllerName ,
               lastName : _controllerLastName ,
                email : _controllerEmail ,
                 password : _controllerpassword , 
                 selectedgender : _selectedGender ,
                  selectedDate : _selectedDate).then((_)  {
                     
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
          );
       return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalization.of(context).translate('update')!,      
        style: TextStyle(color: TColor.black, fontSize: 18, fontWeight: FontWeight.w700),
),
        
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