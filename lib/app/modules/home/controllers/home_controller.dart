import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp/app/modules/home/model/course_model.dart';

class HomeController extends GetxController with StateMixin{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final CollectionReference _collection;

 var courseList = <CourseModel> [].obs;
 
  @override
  void onInit() {
    _collection = _fireStore.collection('Courses');
    readCourses();
    super.onInit();
  }


 Future<void> addCourse({
    required String courseName,
    required String description,
    required String author,
    required String courseImageUrl
  }) async {
    DocumentReference documentReference =
        _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "CourseName": courseName,
      "Description": description,
      "Author" : author,
      "CourseImageUrl":courseImageUrl
    };

    await documentReference
        .set(data)
        .whenComplete(() {
          readCourses();
        })
        .catchError((e) {
         
        });
  }


   readCourses() {
     _collection.get().then((QuerySnapshot query){
        courseList.value = [];
        for (var element in query.docs) {
          courseList.add(CourseModel.fromDocumentSnapshot(element));
        }
    }).onError((error, stackTrace) {
        Get.defaultDialog(
            barrierDismissible: false,
            title: "Error",
            middleText: "Please Try Again!",
            onConfirm: readCourses,
             );
    }).catchError((error){
      Get.defaultDialog(
            barrierDismissible: false,
            title: "Error",
            middleText: "Please Try Again!",
            onConfirm: readCourses,
             );
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
