class ModulesDataModel{

  String name;
  String modIconUrl;
  int completion;

  ModulesDataModel({this.name, this.modIconUrl,this.completion});
  factory ModulesDataModel.fromJSON(Map<String, dynamic> json) {
    return ModulesDataModel(
      name: json['name'],
      modIconUrl: json['modicon'],
      completion: json['completion'],
    );
  }

}