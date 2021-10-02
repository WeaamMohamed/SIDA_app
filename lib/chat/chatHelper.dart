import 'package:firebase_database/firebase_database.dart';

import 'message_model.dart';

///import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHelper {
  //List<SocialUserModel> users = [];
  List users = [];

   static final DatabaseReference _chatsRef =
  FirebaseDatabase.instance.reference().child('Users')
  .child('FANyhIgsIoNsMJN8g0gTv5cqc6Z2').child('chats');

  void getAllChats() {
    //
    // FirebaseFirestore.instance.collection('users').get().then((value)
    // {
    //   value.docs.forEach((element)
    //   {
    //
    //     print(element.id);
    //  ///   users.add(SocialUserModel.fromJson(element.data()));
    //   });
    //
    // });
  }

  static void sendMessage({
    String receiverId,
    String dateTime,
    String text,
  }) {


    String senderId = 'FANyhIgsIoNsMJN8g0gTv5cqc6Z2';
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: senderId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats
    FirebaseDatabase.instance.reference().child('Users')
    //todo: sender id... then receiver id
        .child(senderId).child('chats').child(receiverId).child('messages')
    .push().set(messageModel.toMap());

    // _chatsRef.child(receiverId)
    // .child('messages')
    // .push().set(messageModel.toMap());
    //

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(userModel.uId)
    //     .collection('chats')
    //     .doc(receiverId)
    //     .collection('messages')
    //     .add(model.toMap())
    //     .then((value) {
    //   emit(SocialSendMessageSuccessState());
    // }).catchError((error) {
    //   emit(SocialSendMessageErrorState());
    // });


    // set receiver chats

    ///set receiver chat
    FirebaseDatabase.instance.reference().child('Users')
    //todo: receiver id ... then sender id ;
        .child(receiverId).child('chats').child(senderId).child('messages')
        .push().set(messageModel.toMap());

    // _chatsRef.child('FANyhIgsIoNsMJN8g0gTv5cqc6Z2')
    //     .child('messages')
    //     .push().set(messageModel.toMap());


    //
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(receiverId)
    //     .collection('chats')
    //     .doc(userModel.uId)
    //     .collection('messages')
    //     .add(model.toMap())
    //     .then((value) {
    //   emit(SocialSendMessageSuccessState());
    // }).catchError((error) {
    //   emit(SocialSendMessageErrorState());
    // });

  }
}
