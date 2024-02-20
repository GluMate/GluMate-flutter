import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final VoidCallback? onLogin;

  LoginForm({
    Key? key,
    this.onLogin,
    required this.controllerEmail,
    required this.controllerPassword,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? password;
  RegExp get _emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/login.png",
                  height: 300,
                  width: 450,
                ),
                CustomTextFormField(
                  label: AppLocalization.of(context).translate('email')!,
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
                CustomTextFormField(
                  label: AppLocalization.of(context).translate('password')!,
                  controller: widget.controllerPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalization.of(context)
                          .translate('password_empty')!;
                    } else {
                      if (value.length < 6) {
                        return AppLocalization.of(context)
                            .translate('password_error')!;
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
                SizedBox(height: 25),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomStyledButton(
                            () {
                              if (_formKey.currentState!.validate()) {
                                widget.onLogin!();
                              }
                            },
                            AppLocalization.of(context).translate('sign_in')!,
                          ),
                        ],
                      ),
                      SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(235, 169, 167, 167),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              AppLocalization.of(context).translate('or')!,
                              style: TextStyle(
                                color: Color.fromARGB(255, 103, 162, 211),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Color.fromARGB(235, 169, 167, 167),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/google_png.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 50),
                          IconButton(
                            icon: Icon(
                              Icons.facebook,
                              size: 35,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          backgroundColor: Color.fromARGB(255, 76, 139, 175),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
}
