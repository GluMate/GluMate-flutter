import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/EditProfilePage.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/Round_Button.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/title_subtitle.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Notification/SettingRow.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrConnectedCachedUser();
  }

  bool positive = false;

  List accountArr = [
    {"image": "assets/p_personal.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/p_achi.png", "name": "Achievement", "tag": "2"},
    {"image": "assets/p_activity.png", "name": "Activity History", "tag": "3"},
    {"image": "assets/p_workout.png", "name": "Workout Progress", "tag": "4"}
  ];

  List otherArr = [
    {"image": "assets/p_contact.png", "name": "Contact Us", "tag": "5"},
    {"image": "assets/p_privacy.png", "name": "Privacy Policy", "tag": "6"},
    {"image": "assets/p_setting.png", "name": "Setting", "tag": "7"},
  ];

String calculateAge(DateTime? birthDate) {
  if (birthDate == null) return "Unknown";
  
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  
  if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
    age--;
  }

  return age >= 0 ? age.toString() : "Unknown";
}


  @override
  Widget build(BuildContext context) {
    var cachedUser = Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser;
String userAge = calculateAge(cachedUser != null ? DateTime.parse(cachedUser.dateOfBirth ?? '') : null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrLogout();
              if (Provider.of<RegisterAuthProvider>(context, listen: false).errorLogoutMessage.isEmpty) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  Provider.of<RegisterAuthProvider>(context, listen: false).eitherFailureOrLogout();
                  if (Provider.of<RegisterAuthProvider>(context, listen: false).errorLogoutMessage.isEmpty) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "assets/u2.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cachedUser != null ? "${cachedUser.firstName} ${cachedUser.lastName}" : "",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                    cachedUser != null ? "${cachedUser.role} " : "",
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 25,
                    child: RoundButton(
                      title: "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "180cm",
                      subtitle: "Height",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "65kg",
                      subtitle: "Weight",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: userAge,
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: accountArr.length,
                      itemBuilder: (context, index) {
                        var iObj = accountArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () {},
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDevicesView()),
                  );*/
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bluetooth",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/bluetooth.png",
                              height: 15,
                              width: 15,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                "Bluetooth Devices",
                                style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: otherArr.length,
                      itemBuilder: (context, index) {
                        var iObj = otherArr[index] as Map? ?? {};
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () {},
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
