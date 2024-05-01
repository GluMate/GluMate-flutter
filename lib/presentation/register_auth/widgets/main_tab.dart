
import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chat_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/GlucoseForm.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/home_view.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Profile/profile.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/tabButton.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/pages/main_tracking_page.dart';
import 'package:provider/provider.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
  
}

class _MainTabViewState extends State<MainTabView> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegisterAuthProvider>(context, listen : false).eitherFailureOrConnectedCachedUser(); 
  }
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();

  @override
  Widget build(BuildContext context) {
 return FutureBuilder(
    future: Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrConnectedCachedUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else {
       return Scaffold(
      backgroundColor: TColor.white,
      body:  PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: TColor.primaryG,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,)
                ]),
            child: 
            Center(
              child:   TabButton(
                icon: "assets/health_tab.png",
                selectIcon: "assets/health_tab_select.png",
                isActive: selectTab == 4,
                onTap: () {
                  selectTab = 4;
                  currentTab =  MainTrackingPage();
                  if (mounted) {
                    setState(() {});
                  }
                }),)
           
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        decoration: BoxDecoration(color: TColor.white, boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
        ]),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
                icon: "assets/home_tab.png",
                selectIcon: "assets/home_tab_select.png",
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  currentTab = const HomeView();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/activity_tab.png",
                selectIcon: "assets/activity_tab_select.png",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                 currentTab = const MyChatUI();
                  if (mounted) {
                    setState(() {});
                  }
                }),

              const  SizedBox(width: 40,),
            TabButton(
                icon: "assets/camera_tab.png",
                selectIcon: "assets/camera_tab_select.png",
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                  // currentTab = const ();
                  if (mounted) {
                    setState(() {});
                  }
                }),
            TabButton(
                icon: "assets/profile_tab.png",
                selectIcon: "assets/profile_tab_select.png",
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                 currentTab = ProfileView(context: context);
                  if (mounted) {
                    setState(() {});
                  }
                })
          ],
        ),
      )),
    );
      }
    } );
   
  }
}
