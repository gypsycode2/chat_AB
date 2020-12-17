import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'message-data.dart';
import 'sender-data.dart';
import 'dart:convert' as convert;
import 'widgets/message-card.dart';
import 'widgets/new-message.dart';
import 'dart:developer' as developer;

const MESSAGE_API_URL = 'https://10.0.2.2:3000/api/message/';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat AB',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Chat AB'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  MessageData _messageData = MessageData('Ahdab','Nanosh','the first message from ahdaboosh');
  String _apiError;

  Widget buildErrorMessage() {
    if (this._apiError != null) {
      return Text(
        this._apiError,
        style: TextStyle(color: Colors.red),
      );
    }
    return Container(width: 0, height: 0);
  }
    Widget buildSenderLabel() {
    return Text(
      'Select a sender to send message',
      style: TextStyle(fontSize: 20.0),
    );
  }
  // Widget buildSenderFormField() {
  //   return DropdownButton<String>(
  //     value: _messageData.sender,
  //     icon: Icon(Icons.arrow_downward),
  //     iconSize: 24,
  //     elevation: 16,
  //     style: TextStyle(
  //       color: Colors.black45,
  //       fontSize: 26,
  //     ),
  //     underline: Container(
  //       height: 2,
  //       color: Colors.black87,
  //     ),
  //     items: <Sender>[
  //       new Sender('Ahdab','1111'),
  //       new Sender('Naser','2222'),
       
  //     ].map<DropdownMenuItem<String>>((Sender value) {
  //       return DropdownMenuItem<String>(
  //         value: value.id,
  //         child: Text(value.name),
  //       );
  //     }).toList(),
  //     onChanged: (String newValue) {
  //       if (this._messageData.data != newValue) {
  //         setState(() {
  //           this._messageData.data = newValue;
  //           fetchMessageData(message: this._messageData.data);
  //         });
  //       }
  //     },
  //   );
  // }
 fetchMessageData({String message}) async {
    var url = MESSAGE_API_URL + message;
    final response = await http.get(url);
    developer.log('log me', name: 'my.app.category');
    stderr.writeln('print me');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this._messageData= MessageData(
          jsonResponse['message']['sender'],
          jsonResponse['message']['reciever'],
          jsonResponse['message']['data'],
        );
        this._apiError = null;
      });
    } else {
      setState(() {
        this._apiError =
            'Unable to retrieve message data from API (HTTP ${response.statusCode})';
      });
    }
  }
    @override
  initState() {
    super.initState();
    fetchMessageData(message: this._messageData.data);
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildErrorMessage(),
              NewMessageWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: NewMessageWidget(),
              ),
              MessageCard(
                messageData: _messageData,
                onTap: () {
                  fetchMessageData(message: this._messageData.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
