class ModelsModel{
final  String id;
  final int created;
  final String root;

  ModelsModel({required this.id, required this.created, required this.root});

  factory ModelsModel.fromJson(Map<String, dynamic> toJson){
    return ModelsModel(
      id: toJson['id'],
       created: toJson['created'],
        root: toJson['root']);
  }

  static List<ModelsModel> modelsfromSnapshot(List modelSnapshot){
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }


}