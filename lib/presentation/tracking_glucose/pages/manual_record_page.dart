

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/pages/main_tracking_page.dart';

import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/custom_date_time_picker.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/custom_tag.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/gluc_indicator.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/gluc_picker.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/reusable_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ManualRecordPage extends StatefulWidget {
  const ManualRecordPage({Key? key}) : super(key: key);

  @override
  _maualRecordPageState createState() => _maualRecordPageState();
}

class _maualRecordPageState extends State<ManualRecordPage> {

ScrollController _scrollController = ScrollController();

bool _isVisible = true;
bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
  
    final glucProvider = Provider.of<GlucoseProvider>(context , listen: false);
    glucProvider.setUnit("mg/dL");
    glucProvider.setMaxGluc1(380);
     glucProvider.setMinGluc1(50);
    glucProvider.setGuc(50, 00);
    glucProvider.setType("");
    _scrollController.addListener(() {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        _isVisible) {
      setState(() {
        _isVisible = false;
        _isEnabled = false;
      });
    }
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
      });
    }
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
         _isEnabled = false;
      });
    }
            if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        _isEnabled) {
      setState(() {
        _isEnabled = false;
      });
    }
     if (_scrollController.position.extentAfter == 0 && glucProvider.type.isNotEmpty) {
    setState(() {
      _isEnabled = true;
    });
  }
  });
  }
  @override
  Widget build(BuildContext context) {

   
       return Consumer<GlucoseProvider>(
      builder: (context, glucProvider, _) {
  return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.transparent,
        title:  Text(AppLocalization.of(context).translate('new_record')!,
        
        style:  GoogleFonts.roboto(color: TColor.primaryColor1),
        ),
         iconTheme: IconThemeData(
    color: TColor.primaryColor1, 
  ),
         automaticallyImplyLeading: true,
         elevation: 0,
      ),
      body: Stack(
        children: [SingleChildScrollView(
          controller: _scrollController,
          child: Container(
                  margin: const EdgeInsets.all(10.0),
          
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(1, 20, 1, 50),
              child:  Column( 
                   children: [
                    
                    GlucPicker(),
             const SizedBox(height: 20),
               glucProvider.type.isNotEmpty ? Container(
            margin: const EdgeInsets.all(5),
            
            child: GlucIndicator()
            ) : Container(),
         const SizedBox(height: 20),
          const GlucTags(),
          const SizedBox(height: 5,),
          
          CustomDateTimePicker(),
          
        
        
            ],
          
          ),
          )
            
           
          ),
          
        ),
       _isVisible ?  AnimatedContainer(
         duration: Duration(milliseconds: 500),
         child: Align(
              alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
          child: Opacity(
        opacity: _isEnabled ? 1.0 : 0.5, 
        child: ElevatedButton(
          
  onPressed: (_isEnabled == false && glucProvider.type.isEmpty )  ? null : () => showRecordConfirmation(context)
   
  ,
   style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                      backgroundColor: TColor.primaryColor1,
                                      shadowColor: const Color.fromARGB(255, 144, 198, 243).withOpacity(1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Add",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20, color: TColor.primaryColor2),
                                    ),
                                  ),
 
),

      ),
          ),
               
             ),
       ) : Container(),
        ]
      )
      
     
      
       );
      }
       );

  }
  void showRecordConfirmation(BuildContext context) {
  final glucProvider = Provider.of<GlucoseProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("New record"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure the dialog fits the content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
               
                children: [
                  const Text("Measurement :"),
                  const SizedBox(width: 20,),
                  Text(glucProvider.gluc.toString()),
                ],
              ),
              Row(
               
                children: [
                  const Text("Note :"),
  const SizedBox(width: 20,),
                  Text(glucProvider.type),
                ],
              ),
              Row(
               
                children: [
               const Text("Date and time :"),
               const SizedBox(width: 20,),
                  Expanded(
                    child: Text(DateTime(
                      glucProvider.Year!,
                      glucProvider.Month!,
                      glucProvider.Day!,
                      (glucProvider.Hour! + 1),
                      glucProvider.Minute!,
                    ).toString(),
                      overflow: TextOverflow.clip,),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await Provider.of<RegisterAuthProvider>(context, listen: false)
                      .eitherFailureOrConnectedCachedUser();
                  final userId =
                      Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser!.id;
                  await glucProvider.eitherFailureOrManualRecord(
                    note: glucProvider.type,
                    unit: glucProvider.unit,
                    gluc: glucProvider.gluc,
                    userId: userId,
                    year: glucProvider.Year!,
                    month: glucProvider.Month!,
                    day: glucProvider.Day!,
                    hour: glucProvider.Hour!,
                    minute: glucProvider.Minute!,
                  );
                           if (   Provider.of<GlucoseProvider>(context, listen: false).manualRecordErrorMessage.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(   Provider.of<GlucoseProvider>(context, listen: false).manualRecordErrorMessage)),
                          );
                            Navigator.of(context).pop();
                        } else {
                            Navigator.of(context).pop();
                              Navigator.of(context).pop();
                        
                        }
  
                },
                child: Text('Add'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

}