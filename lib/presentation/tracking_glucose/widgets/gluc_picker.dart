import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class GlucPicker extends StatefulWidget {

  GlucPicker({Key? key}) : super(key: key);

  @override
  State<GlucPicker> createState() => _GlucPickerState();
}

class _GlucPickerState extends State<GlucPicker> {
 
  int _minGluc1 = 50 ;
int _maxGluc1 = 380 ;
int _minGluc2 = 00 ;
int _maxGluc2 = 99 ;
  int _currentGluc1 = 50; 
  int _currentGluc2 = 0; 
  String _unit = "mg/dL";


@override
void initState() {
   

 _minGluc2 = 00 ;
 _maxGluc2 = 99 ;
   final glucProvider = Provider.of<GlucoseProvider>(context, listen: false);
   _minGluc1 = glucProvider.minluc1 ;
    _maxGluc1 = glucProvider.maxluc1 ;
  _currentGluc1 = glucProvider.gluc1;
  _currentGluc2 = glucProvider.gluc2;
 _unit = glucProvider.unit;
 glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
    super.initState();
    
  }
  @override
  Widget build(BuildContext) {
    return    Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
                         return  Container(
                            margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(12.0),
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: TColor.primaryColor1,
              width: 2
            )
            ),
            
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 NumberPicker(
                              minValue:  _minGluc1,
                             maxValue: _maxGluc1,
                              value: _currentGluc1,
                              zeroPad: false,
                             
                              itemWidth: 50,
                              itemHeight: 40,
                               onChanged: (value){
                                setState(() {
                                  _currentGluc1 = value ;
                                    glucProvider.setGuc(_currentGluc1, _currentGluc2);
                                 glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
                                 
                                });
                              
                               },
                               textStyle: const TextStyle(color: Colors.black , fontSize: 10),
                               selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
                               decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black),
                                  bottom: BorderSide(color: Colors.black))
                                  ),
                              
                               ),
                                NumberPicker(
                              minValue:  _minGluc2,
                             maxValue:  _maxGluc2,
                              value: _currentGluc2,
                              zeroPad: true,
                              infiniteLoop: true,
                              itemWidth: 40,
                              itemHeight: 40,
                               onChanged: (value){
                                setState(() {
                                  _currentGluc2 = value ;
                                  glucProvider.setGuc(_currentGluc1, _currentGluc2);
                                 glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
                                });
                                
                          
                               },
                               textStyle: const TextStyle(color: Colors.black , fontSize: 10),
                               selectedTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
                               decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black),
                                  bottom: BorderSide(color: Colors.black))
                                  ),
                              
                               ),
                               Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _unit = "mg/dL";
                                        _minGluc1 = 50;
                                        _maxGluc1 = 380;
                                        _minGluc2 = 00;
                                        _maxGluc2 = 99;
                                            if (_currentGluc1 < _minGluc1) {
                                            _currentGluc1 = 50;
                                            _currentGluc2 = 00;
                                            glucProvider.setGuc(50, 00);
                                            }
                                      }
                                   
                                      );
                                      glucProvider.setMaxGluc1(_maxGluc1);
                                      glucProvider.setMinGluc1(_minGluc1);
                                        glucProvider.setUnit(_unit);
                                         glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
                                                 
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: _unit == "mg/dL" ? TColor.primaryColor1 : Colors.transparent,
                                            width: _unit == "mg/dL" ? 2 :1),
                                     ),
                                      child:  Text(
                                        "mg/dL",
                                        style: GoogleFonts.roboto(
                                          color: _unit == "mg/dL" ? TColor.primaryColor1 : Colors.black,
                                          fontSize: _unit == "mg/dL" ? 17 : 15,
                                          fontWeight: _unit == "mg/dL" ? FontWeight.w600 : null
                                        ),),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _unit = "mmol/L";
                                          _minGluc1 = 3;
                                        _maxGluc1 = 21;
                                        _minGluc2 = 00;
                                        _maxGluc2 = 99;
                                         if (_currentGluc1 > _maxGluc1) {
                                            _currentGluc1 = 4;
                                              _currentGluc2 = 0;
                                              glucProvider.setGuc(4,0);

                                            }
                                      });
                                        glucProvider.setUnit(_unit);
                                        glucProvider.setMaxGluc1(_maxGluc1);
                                        glucProvider.setMinGluc1(_minGluc1);
                                         glucProvider.checkGlucRange(glucProvider.gluc, glucProvider.unit, glucProvider.type);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                     decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: _unit == "mmol/L" ? TColor.primaryColor1 : Colors.transparent,
                                          width: _unit == "mmol/L" ? 2 :1),
                                     ),
                                      child:  Text(
                                        "mmol/L",
                                        style: GoogleFonts.roboto(
                                          color:_unit == "mmol/L" ? TColor.primaryColor1 : Colors.black,
                                          fontSize: _unit == "mmol/L" ? 17 : 15,
                                          fontWeight: _unit == "mmol/L" ? FontWeight.w600 : null
                                        ),),
                                    ),
                                  ),
                                ],
                               )
                              ],
                                                 
                                                    )
                                                                               );
    });
  

  }
}