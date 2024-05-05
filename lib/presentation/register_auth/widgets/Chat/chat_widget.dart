import 'package:flutter/material.dart';
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
var urlTwo =
    'https://sguru.org/wp-content/uploads/2017/03/cute-n-stylish-boys-fb-dp-2016.jpg';

class MyChatUIState extends State<MyChatUI> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
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
        /*actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.videocam_rounded),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.call),
          ),
        ],*/
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: chatModelList.length,
              itemBuilder: (context, index) =>
                  chatModelList.elementAt(index).isMee
                      ? SenderRowView(
                          index: index,
                        )
                      : ReceiverRowView(
                          index: index,
                        ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0, left: 8),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, right: 10),
                  child: Transform.rotate(
                    angle: 45,
                    child: const Icon(
                      Icons.attachment_outlined,
                      color: Color.fromARGB(255, 102, 127, 217),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, true));
                      animateList();
                      controller.clear();
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, false));
                      animateList();
                      controller.clear();
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8, right: 8),
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
