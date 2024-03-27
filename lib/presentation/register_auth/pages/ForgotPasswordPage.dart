import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/ResetPassword/ForgotPassword.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form1.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/patient_register_form2_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
    int _currentPageIndex = 0;

  final TextEditingController _controllerEmail = TextEditingController();



      void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget currentPage = _currentPageIndex == 0 ? ForgotPassword(
            controllerEmail: _controllerEmail,
           
          ) 
          :  Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) => ForgotPassword(
            controllerEmail: _controllerEmail,
            
      )
          );
       return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalization.of(context).translate('reset')!),
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
             
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );


}}