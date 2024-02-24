import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/home_view.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/login_form_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/main_tab.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(builder: (context, authProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context).translate('welcome_back')!),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginForm(
                controllerEmail: _controllerEmail,
                controllerPassword: _controllerpassword,
                onLogin: () {
                  authProvider.eitherFailureOrLogin(
                    email: _controllerEmail,
                    passsword: _controllerpassword,
                  ).then((result) {
               
                    if (authProvider.errorLoginMessage.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authProvider.errorLoginMessage)),
                      );
                    } else {
                
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainTabView()),
                      );
                    }
                  });
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
