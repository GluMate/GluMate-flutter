
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/register_patient_page.dart';
import 'package:provider/provider.dart';
import '';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/text_form_widget.dart';
import 'package:intl/intl.dart';

class roleWidget extends StatefulWidget {

 

  roleWidget({
    Key? key,
  }) : super(key: key);

  @override
  _roleWidgetState createState() => _roleWidgetState();


}


class _roleWidgetState extends State<roleWidget> {

   int selectedRole = 1 ;
    final _formKey = GlobalKey<FormState>();


  Widget CustomRoleButton(String assetName, int index ,String buttonText) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedRole = index;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedRole == index) ? 2.0 : 0.5,
            color: (selectedRole == index)
                ? Colors.green
                : Colors.blue.shade600),
      ),
      child: Stack(
         children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetName,
                fit: BoxFit.contain,
                width: 120,
                height: 120,
              ),
              SizedBox(height: 5),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (selectedRole == index)
          Positioned(
            top: 5,
            right: 5,
            child: Image.asset(
              "assets/tick-circle.png",
              width: 25,
              fit: BoxFit.cover,
            ),
          ),
      ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Consumer<RegisterAuthProvider>(
    builder: (context, registerProvider, _) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Background content
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center( // Center the row horizontally
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomRoleButton("assets/patient_icon.png", 1 , AppLocalization.of(context).translate('patient')!),
                              SizedBox(width: 40),
                              CustomRoleButton("assets/care_provider_icon.png", 2,AppLocalization.of(context).translate('care_provider')!),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), 
                        ElevatedButton(
                          onPressed: () {
                            if (selectedRole == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPatientPage())
                              );
                            } else {
                              // Handle other actions
                            }
                          },
                          child:  Text(AppLocalization.of(context).translate('next')!),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  );
}

}


