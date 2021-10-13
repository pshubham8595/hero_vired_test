
import 'package:flutter/material.dart';
import 'package:hero_vired_test/models/CourseDataModel.dart';
import 'package:hero_vired_test/webservices.dart';

class CoursesDetailNotifier extends ChangeNotifier{

  bool initiallyDataFetched = false;
  CourseDataModel courseDataModel;
  List<CourseDataModel> courseList = [];

  initialDataFetching()async{
      await WebServices.getAllCourses().then((statusMap){
        if(statusMap['responseCode']== 200){
          if(statusMap['courseList'] != null){
            print("DATA FOUND");
            courseList.clear();
            courseList = statusMap['courseList'];
            print("CourseList:${courseList.length}");

          }
          else{
            print("DATA NOT FOUND");
            courseList.clear();
          }
        }
      });
      initiallyDataFetched = true;
      notifyListeners();
  }

}