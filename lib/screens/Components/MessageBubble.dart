import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  MessageBubble({required this.messageText, required this.messageSender, required this.isMe});
  final String messageText;
  final String messageSender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(messageSender,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.black54,
          ),),
          Material(
          borderRadius: BorderRadius.only(
            topLeft: isMe? Radius.circular(30.0): Radius.zero, 
            bottomLeft: Radius.circular(30.0), //common to both
            bottomRight: Radius.circular(30.0), // common to both
            topRight: isMe? Radius.zero: Radius.circular(30.0),
            ),
          elevation: 5.0,
          color: isMe?Colors.lightBlueAccent: Colors.white12,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            child: Text(
              '$messageText',
                style: TextStyle(
                  color: isMe? Colors.white: Colors.black,
                  fontSize: 15.0,
                ),
              ),
          ),
        ),
        ]
      ),
    );
  }
}
