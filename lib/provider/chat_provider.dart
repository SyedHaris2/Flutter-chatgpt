import 'package:flutter/material.dart';

import '../model/chat_models.dart';
import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModels> chatList = [];
  List<ChatModels> get getchatList {
    return chatList;
  }

  void addUserMessag({required String message}) {
    chatList.add(ChatModels(msg: message, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetanswer(
      {required String message, required String chosenModel}) async {
    chatList.addAll(
        await ApiServices.sendMessage(message: message, modelId: chosenModel));
         notifyListeners();
  }
}
