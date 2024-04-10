
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';

class EditProfile extends StatefulWidget {

  final TextEditingController controllerName;
  final TextEditingController controllerLastName;
  final TextEditingController controllerEmail;
  final void Function(int,DateTime) onNextPressed;
  DateTime selectedDate = DateTime.now();

  EditProfile({
    Key? key,
    required this.controllerName,
    required this.controllerLastName,
    required this.selectedDate,
    required this.onNextPressed, 
    required this.controllerEmail  
  }) : super(key: key);


  @override
  _EditProfileState createState() => _EditProfileState();


}


class _EditProfileState extends State<EditProfile> {

   int selectedGender = 1 ;
   DateTime _selectedDate = DateTime.now();
   final _formKey = GlobalKey<FormState>();
   RegExp get _emailRegex =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  Widget CustomGenderButton(String assetName, int index , String buttonText) {
   return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedGender = index;
        
        });
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        side: BorderSide(
            width: (selectedGender == index) ? 2.0 : 0.5,
            color: (selectedGender == index)
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
                width: 100,
                height: 100,
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
        if (selectedGender == index)
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
Widget build(BuildContext context){
     return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
  return Form(
    key: _formKey,
    child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                top: 0,
                left: 28,
                right: 28,
              ),
                child: Column(
                children: [
                  Image.asset("assets/profile.png",
                  height: 250,
                  width:460,),

             CustomTextFormField(
            label :   AppLocalization.of(context).translate('first_name')!,
            controller : widget.controllerName ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('first_name_empty')!;
              } else {
                if (value.length<3) {
                  return AppLocalization.of(context).translate('first_name_error')!;
                }
              }
              return null;
            },
                        icon: Icons.person,

          ),
            const SizedBox(height: 18), 

                CustomTextFormField(
            label :   AppLocalization.of(context).translate('last_name')!,
            controller : widget.controllerLastName ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('last_name_empty')!;
              } else {
                if (value.length<3) {
                  return AppLocalization.of(context).translate('last_name_error')!;
                }
              }
              return null;
            },
            icon: Icons.person,

          ),
            const SizedBox(height: 18), 

            CustomTextFormField(
                      label: AppLocalization.of(context)
                          .translate('email')!,
                      controller: widget.controllerEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('email_empty')!;
                        } else {
                          if (!_emailRegex.hasMatch(value)) {
                            return AppLocalization.of(context)
                                .translate('email_error')!;
                          }
                        }
                        return null;
                      },
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 20),
         SizedBox(height: 5,),
Row(
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 12.0), 
      child: Icon(
        Icons.calendar_today,
        color: Color.fromARGB(255, 118, 183, 221),
      ),
    ),
    const SizedBox(width: 8), 
    TextButton(
      onPressed: () {
        _selectDate(context);
      },
      child: Text(
        AppLocalization.of(context).translate('select_DOB')!,
      ),
    ),
  ],
),
const SizedBox(height: 10),
                   Center( 
                    child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomStyledButton(
                          () {
                            if (_formKey.currentState!.validate()) {
                              widget.onNextPressed(selectedGender,_selectedDate);
                            }
                          },
                          AppLocalization.of(context).translate('confirm')!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
Widget CustomStyledButton(Function onPressed, String buttonText) {
  return SizedBox(
    width: 200,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Color.fromARGB(255, 118, 183, 221),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

 Future<void> _selectDate(BuildContext context) async {
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1910),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.selectedDate = _selectedDate;
        print(widget.selectedDate);
      });
    }
  }
}


