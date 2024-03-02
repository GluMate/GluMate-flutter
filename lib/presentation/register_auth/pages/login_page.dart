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
    bool _isLoading = false; 


  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(builder: (context, authProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalization.of(context).translate('welcome_back')!),
        ),
        body: AbsorbPointer(
          absorbing: _isLoading,
          child: Opacity(
            opacity: _isLoading ? 0.5 : 1.0,
            child: Container(
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
                    onLogin: () async {
                        setState(() {
                        _isLoading = true; // Set isLoading to true when login button is pressed
                      });
                     await authProvider.eitherFailureOrLogin(
                        email: _controllerEmail,
                        passsword: _controllerpassword,
                      );
                      // await authProvider.eitherFailureOrConnectedUser();
                      
                     setState(() {
                        _isLoading = false; // Set isLoading to true when login button is pressed
                      });
                        if (authProvider.errorLoginMessage.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authProvider.errorLoginMessage)),
                          );
                        } else {
                          await authProvider.eitherFailureOrConnectedCachedUser();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MainTabView()),
                          );
                        }
                      
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
