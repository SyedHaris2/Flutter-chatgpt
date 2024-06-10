import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/model/models_model.dart';

import '../services/api_services.dart';

class ModelsProvider with ChangeNotifier{
  
  
  
  String currentModel = "text-davinci-001";

   

   String get getCurrentModel {
    return currentModel;
   } 
   void setCurrentModel(String newModel){
    currentModel = newModel;
    notifyListeners();
   }
List<ModelsModel> modelList = [];
   List<ModelsModel>  get getModelList  {
    return modelList;
   }
   
  Future<List<ModelsModel>> getAllModels() async{
    modelList =await ApiServices.getModels();
    return   modelList; 
  }
}