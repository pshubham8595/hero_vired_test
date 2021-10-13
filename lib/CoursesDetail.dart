import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_vired_test/controllers/CoursesDetailNotifier.dart';
import 'package:hero_vired_test/controllers/SingleCourseDetailController.dart';
import 'package:provider/provider.dart';

import 'SingleCourseDetailPage.dart';
import 'models/CourseDataModel.dart';

class CoursesDetail extends StatefulWidget {

  @override
  _CoursesDetailState createState() => _CoursesDetailState();
}

class _CoursesDetailState extends State<CoursesDetail> {
  CoursesDetailNotifier notifier;


  @override
  Widget build(BuildContext context) {

    notifier  = Provider.of<CoursesDetailNotifier>(context);
    if(!notifier.initiallyDataFetched){
      notifier.initialDataFetching();
    }

    return new Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: new BoxDecoration(color: Colors.white,
          borderRadius: new BorderRadius.only(topRight: new Radius.circular(30),topLeft: new Radius.circular(30))),
    child: new Column(
      children: [
        new SizedBox(height: 20,),
        Row(children: [
          new SizedBox(width: 40,),
          new Text("Learn Data",style:  GoogleFonts.montserrat(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
          new Expanded(child: Container(),),
          CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black12,
              child: new IconButton(icon: new Icon(Icons.close,color: Colors.black54,size: 15,), onPressed:()=>Navigator.pop(context))),
          new SizedBox(width: 30,),
        ]),
        new SizedBox(height: 20,),

        notifier.initiallyDataFetched?new Expanded(child: notifier.courseList.length ==0?new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("No Courses found",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black54),)
          ],
        ):new ListView.builder(
        itemCount: notifier.courseList.length,
        itemBuilder: (context,int index){
          return singleListItem(notifier.courseList[index]);

        })):Expanded(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new CircularProgressIndicator(

                valueColor:  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                strokeWidth: 1,
              ),
              new SizedBox(height: 10,),
              new Text("Loading..",style: GoogleFonts.montserrat(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w400,fontSize: 15),),
            ],
          ),
        )
      ],
    ),
    );
  }

  singleListItem(CourseDataModel courseDataModel){
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.white,
      child: new Column(
        children: [
          Divider(color: Colors.black12,height: 0.5,thickness: 1,endIndent: 15,indent: 15,),
          new Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        new SizedBox(width: 25,),
                        Expanded(child: new Text(courseDataModel.coursefullname,style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),))
                      ],
                    ),
                    new SizedBox(height: 5,),
                    Row(
                      children: [
                        new SizedBox(width: 25,),
                        Expanded(
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(new Radius.circular(15))
                            ),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.all(new Radius.circular(15)),
                              child: new LinearProgressIndicator(
                                minHeight: 10,
                                backgroundColor: Colors.black12,
                                valueColor:  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                value: courseDataModel.progress/100,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(width: 10,),
                        new Text("${courseDataModel.progress}%",style: GoogleFonts.montserrat(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w400,fontSize: 15),),
                        new SizedBox(width: 10,),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 90,
                width: 90,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) => SingleCourseDetailController(),
                              child: SingleCourseDetailPage(title: courseDataModel.coursename,progress: courseDataModel.progress,courseId: courseDataModel.courseid,),
                            )));
                      },
                      child: new Container(decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,spreadRadius: 2,blurRadius: 8
                          )
                        ]
                      ),
                        padding: new EdgeInsets.all(8),
                        child: new Icon(Icons.play_arrow,color: Colors.white,size: 30,),
                      ),
                    ),
                  ],
                ),
              ),
              new SizedBox(width: 5,)

            ],
          )
        ],
      ),
    );
  }

}
