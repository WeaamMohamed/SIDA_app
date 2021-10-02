import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import 'message_model.dart';

///import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHelper {
  //List<SocialUserModel> users = [];
  List users = [];
  static StreamSubscription<Event> chatStreamSubscription;

  static String senderId = 'FANyhIgsIoNsMJN8g0gTv5cqc6Z2';
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

  static List<MessageModel> chatMessages = [];

  static void getMessages({
    @required String receiverId,
  }) {

    // FirebaseDatabase.instance.reference().child('Users')
    // //todo: receiver id ... then sender id ;
    //     .child(senderId).child('chats').child(senderId).child('messages')
    //     .orderByChild('dateTime')
    // .once();

    chatStreamSubscription = FirebaseDatabase.instance.reference().child('Users')
    //todo: receiver id ... then sender id ;
        .child(senderId).child('chats').child(receiverId).child('messages')
        .orderByChild('dateTime')
    .onValue.listen((event) {
      chatMessages = [];

      print('weaam snapshot : ${event.snapshot}');
      print('weaam snapshot value: ${event.snapshot.value}');
     /// print('weaam snapshot  : ${event.snapshot.value[event.snapshot.key]['dateTime']}');

      var _results = event.snapshot.value;
     List list =  _results.values.toList();

      print('weaam : results list text: ' + list[0]['text'].toString());
      print('weaam : results list text: ' + list[1]['text'].toString());
      print('weaam : results list text: ' + list[2]['text'].toString());
      print('weaam : results list text: ' + list[3]['text'].toString());
      print('weaam : results list text: ' + list[4]['text'].toString());
      print('weaam : results length: ' + list.length.toString());
      /// print('weaam snapshot dateTime: ${event.snapshot.value['dateTime']}');

      // event.docs.forEach((element) {
      //   messages.add(MessageModel.fromJson(element.data()));
      // });


    });

    print('weaam : cancel stream');

    }

    static void cancelStream(){
      chatStreamSubscription.cancel();
      chatStreamSubscription = null;
    }

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel.uId)
  //       .collection('chats')
  //       .doc(receiverId)
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     messages = [];
  //
  //     event.docs.forEach((element) {
  //       messages.add(MessageModel.fromJson(element.data()));
  //     });
  //
  //     emit(SocialGetMessagesSuccessState());
  //   });
  // }

}
