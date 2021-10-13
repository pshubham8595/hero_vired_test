class ModulesDataModel{

  String name;
  String modIconUrl;

  ModulesDataModel({this.name, this.modIconUrl});
  factory ModulesDataModel.fromJSON(Map<String, dynamic> json) {
    return ModulesDataModel(
      name: json['name'],
      modIconUrl: json['modicon'],
    );
  }

}