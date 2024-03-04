
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/text_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';

class registerForm1 extends StatefulWidget {

  final TextEditingController controllerName;
  final TextEditingController controllerLastName;
   int selectedGender = 1 ;
    final void Function(int,DateTime) onNextPressed;
    DateTime selectedDate = DateTime.now();

  registerForm1({
    Key? key,
    required this.controllerName,
    required this.controllerLastName,
    required this.selectedGender,
    required this.selectedDate,
    required this.onNextPressed  
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
          widget.selectedGender = selectedGender ;
        
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
                width: 100,
                height: 100,
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
    child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                top: 0,
                left: 28,
                right: 28,
              ),
                child: Column(
                children: [
                  Image.asset("assets/subscribe.png",
                  height: 220,
                  width:450,),
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
            const SizedBox(height: 18), 

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
          const SizedBox(height: 20,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               CustomGenderButton("assets/male1.jpg", 1 , AppLocalization.of(context).translate('male')!),
                const SizedBox(
                  width:20,
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                          onTap: () {
                           },
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
                            onPressed: () {
                            },
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 15,),
                   Center( 
                    child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomStyledButton(
                          () {
                            if (_formKey.currentState!.validate()) {
                              widget.onNextPressed(selectedGender,_selectedDate);
                            }
                          },
                          AppLocalization.of(context).translate('next')!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
Widget CustomStyledButton(Function onPressed, String buttonText) {
  return SizedBox(
    width: 200,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 118, 183, 221),
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
        widget.selectedDate = _selectedDate;
        print(widget.selectedDate);
      });
    }
  }
}


