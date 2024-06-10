class ChatModels{
  final String msg;
   final int chatIndex;

  ChatModels({required this.msg, required this.chatIndex});

   factory ChatModels.fromJson(Map<String, dynamic> toJson){
    return ChatModels(
       msg: toJson['msg'],
      chatIndex: toJson['chatIndex'],
      
    );
       
  }
}