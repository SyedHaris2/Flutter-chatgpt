import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_chatgpt/model/models_model.dart';
import 'package:http/http.dart' as http;

import '../constants/api_const.dart';
import '../model/chat_models.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$Base_URL/models"), headers: {
        'Authorization': 'Bearer $api_key',
      });

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // debugPrint("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }

      //debugPrint("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        log("temp $value");
      }
      return ModelsModel.modelsfromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
      
    }
  }

  //Post data
  static Future<List<ChatModels>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("model ID $modelId");
      var response = await http.post(
        Uri.parse("$Base_URL/completions"),
        headers: {
          'Authorization': 'Bearer $api_key',
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {"model": modelId, "prompt": message, "max_tokens": 100},
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // debugPrint("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }

      List <ChatModels > chatList = [];
      if(jsonResponse["choices"].length>0){
        //log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(jsonResponse["choices"].length, (index) => ChatModels(
          msg: jsonResponse["choices"][index]["text"], 
          chatIndex: 1),
          );
    
      }
        return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
