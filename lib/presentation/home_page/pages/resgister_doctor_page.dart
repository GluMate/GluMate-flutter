import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/doctor_register_form1.dart';
import 'package:provider/provider.dart';

class RegisterDoctorPage extends StatefulWidget {
  const RegisterDoctorPage({Key? key}) : super(key: key);

  @override
  State<RegisterDoctorPage> createState() => _registerDoctorPageState();
}

class _registerDoctorPageState extends State<RegisterDoctorPage> {
  int _currentPageIndex = 0;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerHours = TextEditingController();
  final TextEditingController _controllerSpecialization = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  void nextPage() {
    setState(() {
      _currentPageIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage = _currentPageIndex == 0
        ? registerDoctorForm1(
            controllerName: _controllerName,
            controllerLastName: _controllerLastName,
            controllerHours: _controllerHours,
            controllerSpecialization: _controllerSpecialization,
            controllerEmail: _controllerEmail,
            onNextPressed: () {
              setState(() {
                _currentPageIndex = 1;
              });
            },
          )
        : Container(); 
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
               AppLocalization.of(context).translate('join_doctors')!,
            ),
          ),
          body: currentPage,
        );
      },
    );
  }
}