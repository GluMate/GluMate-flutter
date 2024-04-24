import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chat_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/GlucoseForm.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/home_view.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Profile/profile.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/tabButton.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
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
                  blurRadius: 2,
                )
              ],
            ),
            child: Icon(
              Icons.health_and_safety,
              color: TColor.white,
              size: 35,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2)),
            ],
          ),
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
                },
              ),
              TabButton(
                icon: "assets/activity_tab.png",
                selectIcon: "assets/activity_tab_select.png",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                  currentTab = GlucoseTrackingForm(controllerEmail: null);
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
              const SizedBox(width: 40,),
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
                },
              ),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
