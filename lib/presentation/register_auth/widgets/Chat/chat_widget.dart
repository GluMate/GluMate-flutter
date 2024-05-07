import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chatModel.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/home_view.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/members.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/receiver_row_view.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/sender_row_view.dart';

class MyChatUI extends StatefulWidget {
  const MyChatUI({Key? key}) : super(key: key);

  @override
  MyChatUIState createState() => MyChatUIState();
}

var url =
    'https://www.dirac.fr/wp-content/uploads/2019/07/medecin-traitant-mutuelle-sante.png';
var urlTwo = 'https://cdn-icons-png.flaticon.com/512/387/387585.png';

class MyChatUIState extends State<MyChatUI> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  late String uid;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  void sendMessage() {
    String messageText = controller.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'text': messageText,
        'senderId': uid,
        'timestamp': Timestamp.now(),
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F3),
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: const Color.fromARGB(255, 102, 127, 217),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
              );
            },
          ),
        ),
        leadingWidth: 30,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          title: const Text(
            'Care Provider',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            'online',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No messages available');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    print(
                        'Index: $index, Docs Length: ${snapshot.data!.docs.length}');
                    if (index < snapshot.data!.docs.length) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>; // Explicit cast
                      if (data != null && data is Map<String, dynamic>) {
                        bool isMe = data['senderId'] == uid;
                        return isMe
                            ? SenderRowView(data: data) // Pass data as argument
                            : ReceiverRowView(
                                data: data); // Pass data as argument
                      } else {
                        print('Invalid data at index $index: $data');
                      }
                    }
                    return SizedBox.shrink();
                  },
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, left: 8),
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Color.fromARGB(255, 102, 127, 217),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: sendMessage,
                  onLongPress: sendMessage,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 102, 127, 217),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
