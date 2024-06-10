import 'dart:developer';

import 'package:flutter/material.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/chat_provider.dart';
import '../provider/models_provider.dart';
import '../services/services.dart';
import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController? textEditingController;
  FocusNode focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController!.dispose();
    focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //List<ChatModels> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(
      context,
    );
    final chatProvider = Provider.of<ChatProvider>(
      context,
    );

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset('assets/robot.png'),
          ),
          title: const Text('AI ChatBot'),
          actions: [
            IconButton(
              onPressed: () async {
                await Services.showModalCheet(context: context);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _scrollController,
                  // shrinkWrap: true,
                  itemCount: chatProvider.getchatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg:  chatProvider.getchatList[index].msg, //chatList[index].msg,
                      chatIndex: chatProvider.getchatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ], 
            const SizedBox(height: 15),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          
                      focusNode: focusNode,
                      style: const TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onFieldSubmitted: (value) async {
                        await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatProvider);
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: 'How Can I help You?',
                          hoverColor: Colors.grey),
                    )),
                    CircleAvatar(
                      backgroundColor:  Colors.blue,
                      child: IconButton(
                          onPressed: () async {
                            await sendMessageFCT(modelsProvider: modelsProvider, chatProvider: chatProvider);
                          },
                          icon: const Icon(Icons.send, color: Colors.black,)),
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        )));
  }

  void scrolllController() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider, required ChatProvider chatProvider}) async {
    if(_isTyping){
      Fluttertoast.showToast(
        msg: "You Can't Send Multiple Message at a Time",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
   
    if(textEditingController!.text.isEmpty){
      Fluttertoast.showToast(
        msg: 'Enter Some Text',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return;
    }
    try {
      String message =  textEditingController!.text;
      setState(() {
        _isTyping = true;
       // chatList  .add(ChatModels(msg: textEditingController!.text, chatIndex: 0));
       chatProvider.addUserMessag(message:message);
        textEditingController!.clear();
        focusNode.unfocus();
      });
      log("Request sent");
      await  chatProvider.sendMessageAndGetanswer(message: message, chosenModel: modelsProvider.getCurrentModel);

      // chatList.addAll(await ApiServices.sendMessage(
      //     message: textEditingController!.text,
      //     modelId: modelsProvider.getCurrentModel));
      setState(() {});
    } catch (e) {
      log("error $e");
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } finally {
      setState(() {
        scrolllController();
        _isTyping = false;
      });
    }
  }
}
