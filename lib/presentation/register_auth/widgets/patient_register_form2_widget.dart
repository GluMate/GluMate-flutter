
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:provider/provider.dart';
import 'patient_register_form2_widget.dart';
import 'package:glumate_flutter/core/errors/failure.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/text_form_widget.dart';
import 'package:intl/intl.dart';

class registerForm2 extends StatefulWidget {
final TextEditingController controllerEmail;
final TextEditingController controllerPassword;
final VoidCallback? onFinsih ;
final VoidCallback? onBack ;

  registerForm2({Key? key ,
  required this.controllerEmail,
  required this.controllerPassword,
 this.onFinsih,
 this.onBack,
  }) : super(key:key);

  @override
  _registerForm2State createState() => _registerForm2State();


}


class _registerForm2State extends State<registerForm2> {

   String? password;
  RegExp get _emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _controllerEmail = TextEditingController() ;
    
    final TextEditingController _controllerpassword = TextEditingController() ;
    final TextEditingController _controllerpasswordconfirm = TextEditingController() ;


 

@override
Widget build(BuildContext context){
    
  return Form(
    key: _formKey,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            label : AppLocalization.of(context).translate('email')!,
            controller : widget.controllerEmail ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('email_empty')!;
              } else {
                if (!_emailRegex.hasMatch(value)) {
                  return AppLocalization.of(context).translate('email_error')!;
                }
              }
              return null;
            },
            
          ),
                      const SizedBox(height: 10), 

              CustomTextFormField(
            label : AppLocalization.of(context).translate('password')!,
            controller : widget.controllerPassword ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('password_empty')!;
              } else {
                if (value.length<6) {
                  return AppLocalization.of(context).translate('password_error')!;
                }
              }
              return null;
            },
            onChanged : (value) {
              setState(() {
                password = value;
              });
            }
            ),
                        const SizedBox(height: 10), 

                CustomTextFormField(
            label : AppLocalization.of(context).translate('confirm_password')!,
            controller : _controllerpasswordconfirm ,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return AppLocalization.of(context).translate('confirm_password_empty')!;
              } else {
                // if (value!= password) {
                //   print(password);
                //   return AppLocalization.of(context).translate('confirm_password_error')!;
                // }
              }
              return null;
            },
            
                ),
        
            const SizedBox(height: 10), 

         Row(
              children: [

       
                  ElevatedButton(onPressed: () {
            
                widget.onBack!();

            
          }, child: Text(AppLocalization.of(context).translate('previous')!)
          ),
                     ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()){
                widget.onFinsih!();

            }
          }, child: Text(AppLocalization.of(context).translate('next')!)
          )
              ],
            )
        ]
  )
  );
    
}
}



