import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel{
  String? courseId;
  String? courseName;
  String? description;
  String? author;
  String? courseImageUrl;
  CourseModel(this.courseId,this.courseName,this.description,this.author,this.courseImageUrl);

   CourseModel.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    courseId = doc.id;
    courseName = data["CourseName"];
    description = data['Description'] ?? "";
    author = data['Author'] ??"";
    courseImageUrl =data['CourseImageUrl']??"";
    //return CourseModel(courseId,courseName,description,author,courseImageUrl);
  }

   Map<String,dynamic> toMap(){
    final Map<String,dynamic> data = {};
    data["id"] = courseId;
    data["CourseName"] = courseName;
    data["Description"] = description;
    data["Author"] = author;
    data["courseImageUrl"] = courseImageUrl;
    return data;


  }
}