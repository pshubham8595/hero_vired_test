import 'dart:convert';

import 'package:hero_vired_test/models/CourseDataModel.dart';
import 'package:hero_vired_test/models/SingleCourseDataModel.dart';
import 'package:http/http.dart' as http;

class WebServices{



  static Future<Map<String,dynamic>> getAllCourses()async{
    Map<String,dynamic> statusMap = {};
    List<dynamic> courseList = [];
    String url = "https://vlearn.herovired.com/webservice/rest/server.php?wstoken=8ea3569f9bfad5da4000873a4d7d560d&wsfunction=block_courses_get_courses&moodlewsrestformat=json&start=0&limit=0&userid=761";
    http.Response response ;
    response = await http.get(Uri.parse(url));
    final result = jsonDecode(response.body);
    print("GetAllCourses ... ${response.statusCode} ");
    if(response.statusCode == 200){
      if(result['coursedata'] != null){
        Iterable list = result['coursedata'];
        courseList = list.map((e) => CourseDataModel.fromJSON(e)).toList();
        print(courseList.length);
        statusMap = {
          "responseCode":response.statusCode,
          "courseList":courseList
        };
      }
      else{
        print("CourseDetails list null");
        statusMap = {
          "responseCode":response.statusCode,
          "courseList":null
        };
      }

    }
    else  {
      print("${response.statusCode} ERROR:${response.body}");
      statusMap = {
        "responseCode":response.statusCode,
        "error":"Something went wrong please try again later!."
      };
    }
    return statusMap;
  }
  static Future<Map<String,dynamic>> getSingleCourseDetail(int courseId)async{
    Map<String,dynamic> statusMap = {};
    List<dynamic> topicsList = [];
    String url = "https://vlearn.herovired.com/webservice/rest/server.php?moodlewsrestformat=json&wsfunction=core_course_get_contents&wstoken=8ea3569f9bfad5da4000873a4d7d560d&courseid=$courseId";
    http.Response response ;
    response = await http.get(Uri.parse(url));
    final result = jsonDecode(response.body);
    print("SingleCourseDetail ... ${response.statusCode} ${response.body}");
    if(response.statusCode == 200){
      if(result.length > 0){
        Iterable list = result;
        topicsList = list.map((e) => SingleCourseDataModel.fromJSON(e)).toList();
        print(topicsList.length);
        statusMap = {
          "responseCode":response.statusCode,
          "topicsList":topicsList
        };
      }
      else{
        print("CourseDetails list null");
        statusMap = {
          "responseCode":response.statusCode,
          "topicsList":null
        };
      }

    }
    else  {
      print("${response.statusCode} ERROR:${response.body}");
      statusMap = {
        "responseCode":response.statusCode,
        "error":"Something went wrong please try again later!."
      };
    }
    return statusMap;
  }
}

//Shop Act
//Registration
//CA Firm Start
//Startup India through
//Register firm name and logo
//Data security certification
//Travelling certificate
//Online payment certification
//ISO certification
//Pvt ltd/Partnership/LLP/sole purpose entership
//Current account
//Single owner company
//Udyog Adhar
//Proprietor ship license
//queuekyun domain

//Register under startup india for 5 year Tax beifits (If idea is unique)
//If starting within 2 people go for LLP
//Type of companies
//  Proprietor Ship - Less Compliances Shop Act, MSME,GST (if crossing 40 lac yearly turnover) Tax Acc to income slab 3k Mutual understanding Bond
//  One person Company (Between Partnership - Proprietor Ship)
//  Partnership - Min 2  Flat 30 % Tax() (Registered under State Gov) 5k
//  LLP - Buisness name stays unique and that Name can't be used by any other company,Annual Compliances ,AGM ,Director KYC (Registered under Central Gov)
//        10k,(DEN no)(Director Identification Number)
//  Pvt Ltd - Name stands Unique as well,(Registered under Central Gov) 12k
//  OD account and CC Account Audit.
//



