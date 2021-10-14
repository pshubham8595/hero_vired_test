import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/Constants.dart';
import '../notifiers/SingleCourseDetailController.dart';
import '../models/SingleCourseDataModel.dart';

class SingleCourseDetailPage extends StatefulWidget {
  int courseId;
  int progress;
  String title;

  SingleCourseDetailPage({this.courseId, this.progress, this.title});

  @override
  _SingleCourseDetailPageState createState() => _SingleCourseDetailPageState();
}

class _SingleCourseDetailPageState extends State<SingleCourseDetailPage> {
  SingleCourseDetailController notifier;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<SingleCourseDetailController>(context);
    if (!notifier.initiallyDataFetched) {
      notifier.initialDataFetching(widget.courseId);
    }

    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "${widget.title}",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        body: new Column(
          children: [
            new SizedBox(
              height: 15,
            ),
            new Row(
              children: [
                new SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: new Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                new SizedBox(
                  width: 20,
                ),
              ],
            ),
            new SizedBox(
              height: 15,
            ),
            Row(
              children: [
                new SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(15))),
                    child: ClipRRect(
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(15)),
                      child: new LinearProgressIndicator(
                        minHeight: 10,
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                        value: widget.progress / 100,
                      ),
                    ),
                  ),
                ),
                new SizedBox(
                  width: 10,
                ),
                new Text(
                  "${widget.progress}%",
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                new SizedBox(
                  width: 75,
                ),
              ],
            ),
            new SizedBox(
              height: 15,
            ),
            notifier.initiallyDataFetched
                ? new Expanded(
                    child: notifier.topicsList.length == 0
                        ? Center(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  "No Courses found",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                          )
                        : new ListView.builder(
                            itemCount: notifier.topicsList.length,
                            itemBuilder: (context, int index) {
                              return new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  singleTopicItem(
                                      notifier.topicsList[index], index)
                                ],
                              );
                            }))
                : Expanded(
                    child: Center(
                      child: Constants.loadingColumn(context),
                    ),
                  )
          ],
        ));
  }

  singleTopicItem(SingleCourseDataModel singleCourseDataModel, int index,{bool isExpanded = false}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, right: 2, left: 2),
            child: new Container(

              width: MediaQuery.of(context).size.width * 0.92,
              decoration: new BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: new BorderRadius.all(new Radius.circular(8))),
              child: new ExpansionTile(
                initiallyExpanded: false,
                title: new Text(
                  "${index+1} ${singleCourseDataModel.name}",
                  style: GoogleFonts.montserrat(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
                children: singleCourseDataModel.modulesList.asMap().map((i,e) {
                  return MapEntry(i, Padding(
                    padding:  EdgeInsets.only(top: 2.5),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 5,right: 5),
                      child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(new Radius.circular(8)),
                                color: e.completion == 1?Colors.white:Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          width: MediaQuery.of(context).size.width * 92,
                          height: 50,
                          child: Row(
                            children: [
                              new SizedBox(width: 10,),
                              SvgPicture.network(
                                "${e.modIconUrl}",
                                width: 25,
                                height: 25,
                                placeholderBuilder: (BuildContext context) => Container(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        child: const CircularProgressIndicator(strokeWidth: 1.5,))),
                              ),
                              // Expanded(child: new Text("${e['name']}",overflow: TextOverflow.ellipsis,style: GoogleFonts.montserrat(fontSize: 20.0, fontWeight: FontWeight.w400))),
                              new SizedBox(width: 10,),
                              Expanded(
                                  child: new Text("${index+1}.${(i+1).toString()}   ${e.name}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600))),
                              e.completion == 1?new Container(
                                height: 20,
                                width: 20,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1
                                  )
                                ),
                                child: new Icon(Icons.done,size: 15,color: Theme.of(context).primaryColor,),

                              ):new Container(),
                              new SizedBox(width: 10,)
                            ],
                          )),
                    ),
                  ));
                }).values.toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
