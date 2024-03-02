import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatefulWidget {

  CustomDateTimePicker({Key? key}) : super(key: key);

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
 


  int? _currentHour ; 
  int? _currentMinute ; 
   int? _currentYear ; 
    int? _currentMonth ; 
      int? _currentDay ; 
  int? _maxYear =DateTime.now().year;
   int _maxMonth =DateTime.now().month;
   int _maxDay = DateTime.now().day;

   int? _maxHour ;
      int? _maxMinute ;

     int _minYear = 1900 ;
   int _minMonth = 1;
   int _minDay = 1;
  


@override
void initState() {

   final glucProvider = Provider.of<GlucoseProvider>(context, listen: false);
 _maxMonth =DateTime.now().month;
 _maxDay = DateTime.now().day;
 _maxHour =  DateTime.now().hour;
 _maxMinute = DateTime.now().minute;
   _currentHour =DateTime.now().hour;
  _currentMinute = DateTime.now().minute;
    _currentYear = DateTime.now().year;
 _currentMonth = DateTime.now().month;
  _currentDay = DateTime.now().day;
  glucProvider.setYear(DateTime.now().year);
   glucProvider.setMonth(DateTime.now().month);
   glucProvider.setDay(DateTime.now().day);
   glucProvider.setHour(DateTime.now().hour);
    glucProvider.setMinute(DateTime.now().minute);
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext) {
    return    Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
                         return  Column(
                           children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Align(
                                 alignment: Alignment.topLeft,
                                child: Text(
                                  AppLocalization.of(context).translate("date_time")!,
                                style: TextStyle(fontWeight: FontWeight.w700),),
                              ),
                            ),
                             Container(
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
                                  minValue:  _maxYear! - 3,
                                 maxValue:  _maxYear!,
                                  value: _currentYear!,
                                  zeroPad: true,
                                  infiniteLoop: false,
                                  itemWidth: 60,
                                  itemHeight: 40,
                                   onChanged: (value){
                                    setState(() {
                                      _currentYear = value ;
                                      if (value < DateTime.now().year) {
                                        _maxMonth = 12;
                                        _updateMaxDay();
                                         _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute;
                                        _maxMinute = 59;
                                        _maxHour = 23;
                                      } else {
                                         _maxMonth = DateTime.now().month;
                                        _currentMonth = DateTime.now().month;
                                        _currentDay = DateTime.now().day;
                                        if(_currentMonth == DateTime.now().month && _currentYear == DateTime.now().year) {
                                          _maxDay = DateTime.now().day;
                                          if (_currentDay == DateTime.now().day){
                                         
                                               _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute;
                                         _maxMinute = DateTime.now().minute;
                                        _maxHour = DateTime.now().hour;
                                            } else {
                                               _maxMinute = 59;
                                        _maxHour = 23;
                                         _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute; 
                                                 
                                            }
                                        } else {
                                          _updateMaxDay();
                                        }
                                       
                             
                                      }
                                              glucProvider.setYear(value);       
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
                               minValue:  01,
                                 maxValue:  _maxMonth,
                                  value: _currentMonth!,
                                  zeroPad: true,
                                  infiniteLoop: true,
                                  itemWidth: 40,
                                  itemHeight: 40,
                                   onChanged: (value){
                                    setState(() {
                                            
                                      _currentMonth= value ;
                                    
                                      if (_currentYear == DateTime.now().year && value == DateTime.now().month) {
                                           _currentDay = DateTime.now().day;
                                            _maxDay = DateTime.now().day;
                                            if (_currentDay == DateTime.now().day){
                                         
                                               _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute;
                                         _maxMinute = DateTime.now().minute;
                                        _maxHour = DateTime.now().hour;
                                            } else {
                                               _maxMinute = 59;
                                        _maxHour = 23;
                                         _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute; 
                                                 
                                            }
                                      }else {
                                                    _maxMinute = 59;
                                        _maxHour = 23;
                                         _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute; 
                                       _updateMaxDay();
                                         if(_currentMonth == DateTime.now().month) {
                                          _maxDay = DateTime.now().day;
                                        }
                                      _currentDay = DateTime.now().day;
                             
                                      }
                                       glucProvider.setMonth(value);   
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
                               minValue:  01,
                                 maxValue:  _maxDay,
                                  value: _currentDay!,
                                  zeroPad: true,
                                  infiniteLoop: true,
                                  itemWidth: 40,
                                  itemHeight: 40,
                                   onChanged: (value){
                                    setState(() {
                                      _currentDay = value ;
                                       if (_currentYear == DateTime.now().year && _currentMonth == DateTime.now().month && value == DateTime.now().day) {
                                         _maxHour = DateTime.now().hour;
                                         _maxMinute = DateTime.now().minute;
                                            _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute;
                                        
                                      } else {
                                        _maxHour = 23;
                                         _maxMinute = 59;
                                            _currentHour = DateTime.now().hour;
                                         _currentMinute = DateTime.now().minute;
                                        
                                      }
                                       glucProvider.setDay(value);   
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
                                   Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                     NumberPicker(
                                  minValue:  00,
                                 maxValue: _maxHour!,
                                  value: _currentHour!,
                                  zeroPad: true,
                                  infiniteLoop: true,
                                 
                                  itemWidth: 50,
                                  itemHeight: 40,
                                   onChanged: (value){
                                    setState(() {
                                      _currentHour = value ;
                                         glucProvider.setHour(value);   
                                         
                                  
                                                
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
                                   const Text(":"),
                                    NumberPicker(
                                  minValue:  00,
                                 maxValue:  _maxMinute!,
                                  value: _currentMinute!,
                                  zeroPad: true,
                                  infiniteLoop: true,
                                  itemWidth: 40,
                                  itemHeight: 40,
                                   onChanged: (value){
                                    setState(() {
                                      _currentMinute = value ;
                                         glucProvider.setMinute(value);   
                                    
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
                                  
                                   )
                                  ] )
                                  ],
                                                     
                                                        )
                                                                                   ),
                           ],
                         );
    });
  

  }

 void _updateMaxDay() {
    final lastDayOfMonth = DateTime(_currentYear!, _currentMonth! + 1, 0).day;
    _maxDay = lastDayOfMonth;
    if (_currentDay! > _maxDay) {
      _currentDay = _maxDay;
    }
  }
 
}