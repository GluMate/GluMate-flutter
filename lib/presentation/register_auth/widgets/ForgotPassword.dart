import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/home_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ForgotPasswordView extends StatefulWidget {
  late final TextEditingController controllerEmail;

 
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String? password;
  RegExp get _emailRegex =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

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
                                 //widget.onLogin!();
                              }
                            },
                            AppLocalization.of(context).translate('sign_in')!,
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
          primary: Color.fromARGB(255, 76, 139, 175),
          onPrimary: Colors.white,
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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      print('User signed in with Google: ${user?.displayName}');

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
