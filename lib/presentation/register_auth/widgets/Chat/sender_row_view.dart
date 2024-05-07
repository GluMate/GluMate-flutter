import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chatModel.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/members.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chat_widget.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:cloud_firestore/cloud_firestore.dart';

class SenderRowView extends StatelessWidget {
  final Map<String, dynamic> data;

  const SenderRowView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the timestamp from the data
    Timestamp timestamp = data['timestamp'];
    DateTime messageTime = (data['timestamp'] as Timestamp).toDate();
    String formattedTime = DateFormat.Hm().format(messageTime);

    return ListTile(
      leading: Container(
        width: 50,
      ),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 189, 200, 240),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            data['text'],
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 8, top: 4),
        child: Text(
          formattedTime, // Display the formatted time
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 10),
        ),
      ),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://cdn-icons-png.flaticon.com/512/387/387585.png'),
      ),
    );
  }
}
