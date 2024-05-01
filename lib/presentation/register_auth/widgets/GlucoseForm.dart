import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';
import 'package:provider/provider.dart';

class GlucoseTrackingForm extends StatefulWidget {
  final TextEditingController? controllerEmail;

  GlucoseTrackingForm({
    Key? key,
    required this.controllerEmail,
  }) : super(key: key);

  @override
  _GlucoseTrackingFormState createState() => _GlucoseTrackingFormState();
}

class _GlucoseTrackingFormState extends State<GlucoseTrackingForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, _) {
        return _isLoading ? _buildLoadingScreen() : _buildForm();
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 28,
            right: 28,
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/Diabete.gif",
                height: 300,
                width: 500,
              ),
              SizedBox(height: 40),
              Text(
                AppLocalization.of(context).translate('please_enter_sugar_blood')!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25,),
              SizedBox(
                width: 248, 
                child: CustomTextFormField(
                  label: AppLocalization.of(context).translate('sugar')!,
                  controller: widget.controllerEmail ?? TextEditingController(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalization.of(context).translate('sugar_empty')!;
                    } 
                    return null;
                  },
                  icon: Icons.bloodtype,
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomStyledButton(
                      () async {
                        if (_formKey.currentState!.validate()) {
                        }
                      },
                      AppLocalization.of(context).translate('envoyer')!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget CustomStyledButton(Function onPressed, String buttonText) {
    return SizedBox(
      width: 150, 
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
}
