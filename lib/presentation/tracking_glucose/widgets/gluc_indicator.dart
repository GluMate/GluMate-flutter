import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class GlucIndicator extends StatefulWidget {
  GlucIndicator({Key? key}) : super(key: key) ;

  @override
  State<GlucIndicator> createState() => _GlucIndicatorState();
}



class _GlucIndicatorState extends State<GlucIndicator>{

  final List<MaterialColor> _colors = [
 Colors.deepOrange,
 Colors.yellow,
Colors.green,
Colors.orange,
Colors.red
  ];

dynamic? _iconColor ;
  double _sliderValue = 0; // Value to control the position of the slider thumb


@override
void initState() {
    super.initState();
     final glucProvider = Provider.of<GlucoseProvider>(context, listen: false);
 _iconColor =  glucProvider.iconColor;
  }
            Widget coloredContainer(int index) {
              return  
              Expanded(
                child: Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  color: _colors[index],
                  borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                  ),
                
                ),
                          ),
              );
              } 


  @override
  Widget build(BuildContext context) {
     return Consumer<GlucoseProvider>(builder: (context , glucProvider , _) {
     return 
       Column(
         children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                  Icons.circle, 
                  color: glucProvider.iconColor!, 
                  size: 15, 
                ),
                SizedBox(width: 5,),
                Text(glucProvider.range,
                style: GoogleFonts.roboto(color: glucProvider.iconColor,
                fontSize: 15,
                fontWeight: FontWeight.w600),),
            ],
          ),
        
           Column(
             children: [
SfSliderTheme(
            data: SfSliderThemeData(
              thumbColor: Colors.white,
            
              thumbStrokeWidth: 2,
              thumbStrokeColor: glucProvider.iconColor,
              inactiveTrackColor: Colors.transparent,
              activeTrackColor: Colors.transparent
            ),
                    child: SfSlider(
                      value: glucProvider.indicator,
                      min: 0,
                      max: 4, 
                       thumbIcon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: glucProvider.iconColor,
                    size: 15),// Adjust this value according to the number of colored containers
                      onChanged: (value) {
                        // No-op: Prevent slider interaction
                      },
                    ),
                  ),
                
                        
                Row(
                  children: [
                    coloredContainer(0),
                    coloredContainer(1),
                    coloredContainer(2),
                    coloredContainer(3),
                     coloredContainer(4),
               
                  ],
                ),
                SizedBox(height: 20,),
               Center(
  child: Text(
    glucProvider.hint,
    textAlign: TextAlign.center, 
    style: TextStyle(
      fontWeight: FontWeight.w500
    ),// Ensures text is centered within the widget
  ),
)

               
                         ],
                      
             
           ),
         ],
       );
     });   
  }
  }

