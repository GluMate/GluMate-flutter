import 'package:flutter/material.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/EditProfilePage.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/login_page.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/Round_Button.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/title_subtitle.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Notification/SettingRow.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Register/role_widget.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/contactUs.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
    final BuildContext context;

  const ProfileView({Key? key, required this.context}) : super(key: key);

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
    {"image": "assets/p_personal.png", "name": "Personal Data", "tag": "1", "route": EditProfilePage()},
    {"image": "assets/p_achi.png", "name": "Achievement", "tag": "2", "route": roleWidget()},
    {"image": "assets/p_workout.png", "name": "Activity History", "tag": "3", "route": null},
  ];

 List otherArr(BuildContext context) => [
  {"image": "assets/p_contact.png", "name": "Contact Us", "tag": "5", "route": ContactUsScreen()},
  {
    "image": "assets/p_privacy.png",
    "name": "Privacy Policy",
    "tag": "6",
    "onTap": () {
      _showPrivacyDialog(context);
    },
  },
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

  String getProfileImage(String? gender) {
    if (gender == 'male') {
      return "assets/avatar.png";
    } else if (gender == 'female') {
      return "assets/u2.png";
    } else {
      return "assets/user_text.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    var cachedUser = Provider.of<RegisterAuthProvider>(context, listen: false).cachedUser;
    String userAge = calculateAge(cachedUser != null ? DateTime.parse(cachedUser.dateOfBirth ?? '') : null);
    String profileImage = getProfileImage(cachedUser != null ? cachedUser.gender : null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
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
                      profileImage,
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
                      for (var item in accountArr)
                        SizedBox(
                          height: 30,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => item["route"],
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item["image"],
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
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
              GestureDetector(
                onTap: () {
                  /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDevicesView()),
                  );*/
                },
                child:
                Container(
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

                      for (var item in otherArr(context))
                        SizedBox(
                          height: 30,
                          child: GestureDetector(
                            onTap: () {
                              if (item['name'] == 'Privacy Policy') {
                                item['onTap']();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => item["route"],
                                  ),
                                );
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item["image"],
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    item["name"],
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your privacy is important to us.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'We collect minimal user data necessary for the functioning of our app. This may include basic analytics data such as device type, screen resolution, and usage statistics. We do not collect any personally identifiable information unless explicitly provided by the user for specific features.',
                ),
                SizedBox(height: 16.0),
                Text(
                  'By using our app, you agree to our Privacy Policy.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
