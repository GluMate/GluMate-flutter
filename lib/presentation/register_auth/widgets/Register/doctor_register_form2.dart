import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';

class RegisterDoctorForm2 extends StatefulWidget {
  final TextEditingController controllerBio;
  final TextEditingController controllerDiploma;
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmPassword;
  final VoidCallback? onFinish;
  final VoidCallback? onBack;

  RegisterDoctorForm2({
    Key? key,
    required this.controllerBio,
    required this.controllerPassword,
    required this.controllerConfirmPassword,
    required this.controllerDiploma,
    this.onFinish,
    this.onBack,
  }) : super(key: key);

  @override
  _RegisterDoctorForm2State createState() => _RegisterDoctorForm2State();
}

class _RegisterDoctorForm2State extends State<RegisterDoctorForm2> {
  String? password;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerBio = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();
  final TextEditingController _controllerpasswordconfirm = TextEditingController();
  final TextEditingController _controllerDiploma = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/subscribe.png", 
              height: 250,
              width: 460,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomTextFormField(
                      label: AppLocalization.of(context)
                          .translate('specialization')!,
                      controller: widget.controllerBio,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('specialization_empty')!;
                        } else {
                          if (value.length<6) {
                            return AppLocalization.of(context)
                                .translate('specialization_error')!;
                          }
                        }
                        return null;
                      },
                      icon: Icons.description,
                    ),
                    const SizedBox(height: 20),
                     CustomTextFormField(
                      label: AppLocalization.of(context)
                          .translate('specialization')!,
                      controller: widget.controllerDiploma,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('specialization_empty')!;
                        } else {
                          if (value.length<6) {
                            return AppLocalization.of(context)
                                .translate('specialization_error')!;
                          }
                        }
                        return null;
                      },
                      icon: Icons.school,
                    ),
                    CustomTextFormField(
  label: AppLocalization.of(context).translate('password')!,
  controller: widget.controllerPassword,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context).translate('password_empty')!;
    } else {
      if (value.length < 6) {
        return AppLocalization.of(context).translate('password_error')!;
      }
    }
    return null;
  },
  icon: Icons.password,
  onChanged: (value) {
    setState(() {
      password = value;
    });
  },
),
const SizedBox(height: 20),
CustomTextFormField(
  label: AppLocalization.of(context).translate('confirm_password')!,
  controller: _controllerpasswordconfirm,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return AppLocalization.of(context).translate('confirm_password_empty')!;
    } else {
      if (value != password) {
        return AppLocalization.of(context)
            .translate('confirm_password_error')!;
      }
    }
    return null;
  },
  icon: Icons.password,
),

                    const SizedBox(height: 30),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(218, 91, 169, 233),
                            minimumSize: Size(150, 50), // Adjust size
                          ),
                          onPressed: () {
                            widget.onBack!();
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('previous')!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(218, 91, 169, 233),
                            minimumSize: Size(150, 50), // Adjust size
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onFinish!();
                            }
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate('next')!,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}