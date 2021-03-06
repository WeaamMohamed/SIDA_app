import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sida_app/chat/chatHelper.dart';

import 'message_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        ChatHelper.getMessages(receiverId: 'ayYZ3QcUiBWVTmOPITTG8Fkw1i73');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0.0,
            title: Row(
              children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 22.0,
                  //todo: change image & name
                  backgroundImage: NetworkImage(
                    'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Weaam Mohamed',
                  style: TextStyle(

                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                _buildMessage(MessageModel(text: "hi there ",
                    dateTime: DateTime.now().toString(),
                    receiverId: 'dijd',
                    senderId: 'kajdi')),
                _buildMyMessage(MessageModel(text: "I have arrived",
                    dateTime: DateTime.now().toString(),
                    receiverId: 'dijd',
                    senderId: 'kajdi')),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),

                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message here ...',
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 50.0,
                        color: Colors.black87,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {

                            ChatHelper.sendMessage(receiverId: 'ayYZ3QcUiBWVTmOPITTG8Fkw1i73',
                                dateTime: DateTime.now().toString(), text: messageController.text);
                            messageController.clear();
                            // SocialCubit.get(context).sendMessage(
                            //   receiverId: userModel.uId,
                            //   dateTime: DateTime.now().toString(),
                            //   text: messageController.text,
                            // );
                          },
                          minWidth: 1.0,
                          child: Icon(
                            Icons.send_rounded,
                            size: 22.0,
                            color: Colors.white,
                          ),
                          // child: SvgPicture.asset('assets/images/Send.svg', color: Colors.white,),

                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
  Color defaultColor = Colors.black;

  Widget _buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          child: Text(
            model.text,
            style: TextStyle(
                fontSize: 16,
            ),
          ),
        ),
      );

  Widget _buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            // color: defaultColor.withOpacity(
            //   .2,
            // ),
            color: Colors.black,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          child: Text(
            model.text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          ),
        ),
      );

  // Widget _getMessageList() {
  //   return Expanded(
  //     child: FirebaseAnimatedList(
  //       controller: mes,
  //       query: widget.messageDao.getMessageQuery(),
  //       itemBuilder: (context, snapshot, animation, index) {
  //         final json = snapshot.value as Map<dynamic, dynamic>;
  //         final message = Message.fromJson(json);
  //         return MessageWidget(message.text, message.date);
  //       },
  //     ),
  //   );
  // }


@override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    ChatHelper.cancelStream();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ChatHelper.cancelStream();

  }
}

