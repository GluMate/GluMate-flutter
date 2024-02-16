
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/text_form_widget.dart';

class registerForm1 extends StatefulWidget {

   final TextEditingController controllerName;
  final TextEditingController controllerLastName;
   int selectedGender = 1 ;
   final VoidCallback? onNextPressed ;
    DateTime selectedDate = DateTime.now();

  registerForm1({
    Key? key,
    required this.controllerName,
    required this.controllerLastName,
    required this.selectedGender,
    required this.selectedDate,
    this.onNextPressed
  }) : super(key: key);

  @override
  _registerForm1State createState() => _registerForm1State();


}


class _registerForm1State extends State<registerForm1> {

   int selectedGender = 1 ;
   DateTime _selectedDate = DateTime.now();
    final _formKey = GlobalKey<FormState>();


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
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            
          ),
            const SizedBox(height: 10), 

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
            
          ),
          const SizedBox(height: 10,),
Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               CustomGenderButton("assets/male.jpg", 1 , AppLocalization.of(context).translate('male')!),
               
                const SizedBox(
                  width: 10,
                ),
                 CustomGenderButton(
                      "assets/female.png", 2 , AppLocalization.of(context).translate('female')!),
               
              ],
            ),
        
            const SizedBox(height: 10), 
           
               TextButton(
                  onPressed: () {
                    _selectDate(context);
                    } , 
                    child:  Text(
                      AppLocalization.of(context).translate('select_DOB')!)),
                                const SizedBox(height: 10), 
 Row(
              children: [

       
                  ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()){
                widget.onNextPressed!();

            }
          }, child:  Text(
            AppLocalization.of(context).translate('next')!
          )
          )
              ],
            )
        
        ]
  )
  );
      });
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
      });
    }
  }
}


