import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chatModel.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/members.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReceiverRowView extends StatelessWidget {
  final Map<String, dynamic> data;

  const ReceiverRowView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert timestamp to DateTime
    DateTime messageTime = (data['timestamp'] as Timestamp).toDate();
    // Format the DateTime to display only the time
    String timeString = DateFormat.Hm().format(messageTime);

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://www.dirac.fr/wp-content/uploads/2019/07/medecin-traitant-mutuelle-sante.png'),
        ),
      ),
      title: Wrap(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            data['text'],
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
      trailing: Container(
        width: 50,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8, top: 4),
        child: Text(
          timeString,
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
