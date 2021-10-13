class CourseDataModel {
  int courseid;
  String coursename;
  String coursefullname;
  int progress;
  String image;
  String lpshortname;
  String lpfullname;

  CourseDataModel({this.courseid, this.coursename, this.coursefullname,
    this.progress, this.image, this.lpshortname, this.lpfullname});

  factory CourseDataModel.fromJSON(Map<String, dynamic> json) {
    return CourseDataModel(
      courseid: json['courseid'],
      coursename: json['coursename'],
      coursefullname: json['coursefullname'],
      progress: json['progress'],
      image: json['image'],
      lpshortname: json['lpshortname'],
      lpfullname: json['lpfullname'],
    );
  }

}
