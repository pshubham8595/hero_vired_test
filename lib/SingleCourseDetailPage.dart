import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'notifiers/SingleCourseDetailController.dart';
import 'models/SingleCourseDataModel.dart';

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
                  width: 40,
                ),
                new Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            new SizedBox(
              height: 15,
            ),
            Row(
              children: [
                new SizedBox(
                  width: 50,
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
                  width: 50,
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
                              return singleTopicItem(
                                  notifier.topicsList[index], index);
                            }))
                : Expanded(
                    child: Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                            strokeWidth: 1,
                          ),
                          new SizedBox(
                            height: 10,
                          ),
                          new Text(
                            "Loading..",
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ));
  }

  singleTopicItem(SingleCourseDataModel singleCourseDataModel, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 2, left: 2),
          child: new Container(
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: new BoxDecoration(
                color: Colors.black12,
                borderRadius: new BorderRadius.all(new Radius.circular(8))),
            child: new ExpansionTile(
              title: Container(
                decoration: new BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    singleCourseDataModel.name,
                    style: GoogleFonts.montserrat(
                        fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              children: singleCourseDataModel.modulesList.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Row(
                    children: [
                      new Image.network(
                        "${e.modIconUrl}",
                        height: 20,
                        width: 20,
                      ),
                      // Expanded(child: new Text("${e['name']}",overflow: TextOverflow.ellipsis,style: GoogleFonts.montserrat(fontSize: 20.0, fontWeight: FontWeight.w400))),
                      Expanded(
                          child: new Text("${e.name}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300))),
                    ],
                  )),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
