import 'package:hero_vired_test/models/ModulesDataModel.dart';

class SingleCourseDataModel{
  String name;
  List <ModulesDataModel> modulesList;
  // Map modulesMap = modulesList.asMap(); // {0: 'apple', 1: 'orange', 2: 'mango'}

  int section;

  SingleCourseDataModel({this.name, this.modulesList, this.section});
  factory SingleCourseDataModel.fromJSON(Map<String, dynamic> json) {
    return SingleCourseDataModel(
      name: json['name'],
      modulesList:getModules(json: json['modules']),
      section: json['section'],
    );
  }

  static getModules({var json}){
    Iterable list = json;
    return list.map((e) => ModulesDataModel.fromJSON(e)).toList();
  }

}

