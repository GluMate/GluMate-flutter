import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Design/colors.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Notification/NotificationRow.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List notificationArr = [
    {
      "image": "assets/notif.png",
      "title": "Adopt a Healthy Diet",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Monitor Blood Sugar Levels Regularly",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Control Portion Sizes",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Stay Hydrated",
      "time": "About a day ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Exercise Regularly",
      "time": "About 2 days ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Manage Stress",
      "time": "About 3 days ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Get Enough Sleep",
      "time": "About 3 days ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Take Medications as Prescribed",
      "time": "About 3 days ago"
    },
    {
      "image": "assets/notif.png",
      "title": "Make Sure You Have Regular Medical Check-Ups",
      "time": "About 3 days ago"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          itemBuilder: ((context, index) {
            var nObj = notificationArr[index] as Map? ?? {};
            return NotificationRow(nObj: nObj);
          }),
          separatorBuilder: (context, index) {
            return Divider(
              color: TColor.gray.withOpacity(0.5),
              height: 1,
            );
          },
          itemCount: notificationArr.length),
    );
  }
}
