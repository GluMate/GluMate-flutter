
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';

import 'package:glumate_flutter/presentation/register_auth/widgets/text_form_widget.dart';

class loginForm extends StatefulWidget {
  final TextEditingController controllerEmail ;
    final TextEditingController controllerPassword ;

  final VoidCallback? onLogin ;

  loginForm({Key? key , 
  this.onLogin ,
  required this.controllerEmail,
  required this.controllerPassword
  }) : super(key:key);

  @override
  _loginFormState createState() => _loginFormState();


}


class _loginFormState extends State<loginForm> {



   String? password;
  RegExp get _emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    final _formKey = GlobalKey<FormState>();


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
          ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()){  
              widget.onLogin!();

            }
          }, child:  Text(AppLocalization.of(context).translate('sign_in')!)
          )
        ]
  )
  );
}

}
