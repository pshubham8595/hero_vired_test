
import 'package:flutter/material.dart';
import 'package:hero_vired_test/models/CourseDataModel.dart';
import 'package:hero_vired_test/models/SingleCourseDataModel.dart';
import 'package:hero_vired_test/webservices/webservices.dart';

class SingleCourseDetailController extends ChangeNotifier{

  bool initiallyDataFetched = false;
  List<SingleCourseDataModel> topicsList = [];


  initialDataFetching(int courseId)async{
      await WebServices.getSingleCourseDetail(courseId).then((statusMap){
        if(statusMap['responseCode']== 200){
          if(statusMap['topicsList'] != null){
            print("DATA FOUND");
            topicsList.clear();
            topicsList = statusMap['topicsList'];
            print("SubCourseList:${topicsList.length}");
          }
          else{
            print("DATA NOT FOUND");
            topicsList.clear();
          }
        }
      });
      initiallyDataFetched = true;
      notifyListeners();
  }

}