import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textEdittingController = TextEditingController();
  final _focusNode = FocusNode();
  var _isWriting = false;
  final List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Column(
            children: const <Widget>[
              CircleAvatar(
                child: Text(
                  "Test",
                  style: TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blueAccent,
                maxRadius: 14.0,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Melissa Flores',
                style: TextStyle(color: Colors.black87, fontSize: 12.0),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, index) => _messages[index],
                reverse: true,
              )),
              const Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textEdittingController,
            onSubmitted: _handleSubmitt,
            onChanged: (String text) {
              setState(() {
                if (text.trim().isNotEmpty) {
                  _isWriting = true;
                } else {
                  _isWriting = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),
          //Boton de enviar
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Enviar'),
                      onPressed: _isWriting
                          ? () => _handleSubmitt(
                              _textEdittingController.text.trim())
                          : null)
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue.shade400),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: const Icon(Icons.send),
                          onPressed: _isWriting
                              ? () => _handleSubmitt(
                                  _textEdittingController.text.trim())
                              : null,
                        ),
                      ),
                    )),
        ],
      ),
    ));
  }

  _handleSubmitt(String text) {
    if (text.isEmpty) return;

    _textEdittingController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      texto: text,
      uid: '1123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
