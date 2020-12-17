import 'package:flutter/material.dart';
import 'package:chat_ab/message-data.dart';
import 'package:flutter/cupertino.dart';

class MessageCard extends StatelessWidget{
  final MessageData messageData;
  final Function onTap;
   MessageCard({Key key, @required this.messageData, @required this.onTap})
      : super(key: key);

      Widget buildMessage(String message){
        return Text(
          message !=null ? message:'',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        );
      }
 
  Widget buildRefreshIcon() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Icon(
        Icons.refresh,
        size: 45,
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      buildMessage(messageData.data),
                      buildRefreshIcon(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}