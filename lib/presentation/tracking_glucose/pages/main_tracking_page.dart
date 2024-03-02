

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/data/datasources/remote/firebase_auth.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/pages/manual_record_page.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/gluc_chart.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/records_list.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/widgets/reusable_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainTrackingPage extends StatefulWidget {
   MainTrackingPage({Key? key}) : super(key: key);

  @override
  State<MainTrackingPage> createState() => _MainTrackingPageState();



}

class _MainTrackingPageState extends State<MainTrackingPage> {
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<GlucoseProvider>(context, listen: false).eitherFailureOrFetchRecords(
      id: Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser!.id,
    );
  }


  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Tracker_page')!,
         style:  GoogleFonts.roboto(color: TColor.primaryColor1),),
            iconTheme: IconThemeData(
    color: TColor.primaryColor1, 
  ),
        
      ),
      body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusableCard(
                cardChild: Column(
                  children: [
                  
                  glucLineChart(),
                        ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualRecordPage(),
                          ),
                        ).then((value) {
                         Provider.of<GlucoseProvider>(context, listen: false).eitherFailureOrFetchRecords(
      id: Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser!.id,
    );
                        });;
                      },
                      child: 
                       const Text("Add record"),
                    ),
                  ],
                ),
                color: Colors.transparent,
              ),
              const SizedBox(height: 10),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text(
                "Recently" ,
                style: TextStyle(fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){}, child: const Text("Show all"))
                ],
              ),
             
              const SizedBox(height: 10,),
              const recordsList(),
            ],
          ),
        ),
      ),
    );
  }
}
