import 'package:chat_app/screens/Components/MessageBubble.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageInputBoxController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
   String messagetext = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() async{
    try{
    final user = await _auth.currentUser;
      if(user != null){
        loggedInUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('Chatting').snapshots(), 
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return CircularProgressIndicator(
                    backgroundColor: Colors.lightBlue,
                    color: Colors.lightBlue,
                  );

                }
                final messages = snapshot.data?.docs.reversed;
                List<MessageBubble> messageWidgets = [];
                for(var message in messages!){
                  final messageText = message.data()['Text'];
                  final messageSender = message.data()['Sender'];
                  final currentUser = loggedInUser.email;

                  final messageWidget = MessageBubble(
                    messageText: messageText, 
                    messageSender: messageSender,
                    isMe: currentUser == messageSender,
                    );
                  messageWidgets.add(messageWidget);
                }
 
                return Expanded(child: ListView( 
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  children: messageWidgets
                  ),
                  );
              },
              ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageInputBoxController,
                      onChanged: (value) {
                        messagetext = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageInputBoxController.clear();
                      _firestore.collection('Chatting').add({
                        'Sender': loggedInUser.email,
                        'Text': messagetext,
                      });

                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


