import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/Chat/chatModel.dart';

class FirebaseChatService {
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  Future<void> sendMessage(String message) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await chatCollection.add({
          'senderId': user.uid,
          'message': message,
          'timestamp': Timestamp.now(),
        });
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<List<ChatModel>> getChatMessages() {
    return chatCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel(
          senderId: doc['senderId'],
          message: doc['message'],
          timestamp: doc['timestamp'],
        );
      }).toList();
    });
  }
}
