import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/Doctor.dart';
import '../widgets/ChatAppBar.dart';

class ChatScreen extends StatefulWidget {
  final Doctor doctor;

  ChatScreen(this.doctor);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  List<String> _messages = [];

  void _sendMessage(String text) {
    setState(() => _messages.insert(0, text));
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(widget.doctor),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (ctx, index) =>
                  messageBubble(context, _messages[index]),
              itemCount: _messages.length,
            ),
          ),
          inputField(context),
        ],
      ),
    );
  }

  Widget inputField(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.8), width: 0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 50,
                maxHeight: 100,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  cursorColor: Colors.grey,
                  controller: _textController,
                  onSubmitted: (text) => _sendMessage(text),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    hintText: 'Send a message',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(_textController.text),
            icon: Icon(
              LineIcons.chevron_circle_right,
              color: Colors.black.withOpacity(0.8),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget messageBubble(BuildContext context, String message) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 0,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(25),
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '12:43',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'R',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
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
