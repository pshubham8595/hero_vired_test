import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'CoursesDetail.dart';
import 'controllers/CoursesDetailNotifier.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String currentScreen = "home";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Theme.of(context).primaryColor),
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: homePageTab(),
            ),
            Positioned(
              bottom: 0,
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 10)
                    ],
                    borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(25),
                        topRight: new Radius.circular(25))),
                child: menu(context, selected: currentScreen),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget menu(BuildContext context, {String selected = "home"}) {
    return Container(
      height: 60,
      color: Colors.transparent,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Icon(
            Icons.home_outlined,
            size: 25,
            color: selected == "home"
                ? Theme.of(context).primaryColor
                : Colors.black26,
          ),
          new Icon(
            Icons.calendar_today,
            size: 20,
            color: selected == "calendar"
                ? Theme.of(context).primaryColor
                : Colors.black26,
          ),
          GestureDetector(
            onTap: () {
              showModalSheet();
            },
            child: new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              padding: new EdgeInsets.all(8),
              child: new Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          new Icon(
            Icons.messenger_outline_sharp,
            size: 20,
            color: selected == "messages"
                ? Theme.of(context).primaryColor
                : Colors.black26,
          ),
          new Icon(
            Icons.person_outline_rounded,
            size: 25,
            color: selected == "profile"
                ? Theme.of(context).primaryColor
                : Colors.black26,
          )
        ],
      ),
    );
  }

  homePageTab() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [new Text("HomePage")],
    );
  }

  showModalSheet() {
    return showModalBottomSheet<void>(
        barrierColor: Colors.black12,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        builder: (BuildContext context) {
          return new ChangeNotifierProvider<CoursesDetailNotifier>(
            create: (c) => CoursesDetailNotifier(),
            child: CoursesDetail(),
          );
        });
  }
}
