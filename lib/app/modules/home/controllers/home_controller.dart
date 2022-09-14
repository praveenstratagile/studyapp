import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp/app/modules/home/model/course_model.dart';

class HomeController extends GetxController with StateMixin{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final CollectionReference _collection;
  
 var s =  ''.obs;
 var courseList = <CourseModel> [].obs;
 TextEditingController courseNameController = TextEditingController();
 TextEditingController courseDescriptionController = TextEditingController();
 TextEditingController courseImageController = TextEditingController();
 TextEditingController courseAuthorController = TextEditingController();
 
  @override
  void onInit() {
    _collection = _fireStore.collection('Courses');
    readCourses();
    super.onInit();
  }


 Future<void> addCourse() async {
    if(!validateCourse()){
      return;
    }

    Map<String, dynamic> newCourse = <String, dynamic>{
      "CourseName": courseNameController.text.trim(),
      "Description": courseDescriptionController.text.trim(),
      "Author" : courseAuthorController.text.trim(),
      "CourseImageUrl":courseImageController.text.trim()
    };

    await _collection.doc()
        .set(newCourse)
        .whenComplete(() {
          Get.back();
           Get.defaultDialog(
            barrierDismissible: true,
            title: "Success",
            middleText: "Course added Successfully!",
            //onConfirm: readCourses,
             );
          readCourses();
        })
        .catchError((e) {
         
        });
  }

  validateCourse(){
    if(courseNameController.text.trim()==""){
      Get.snackbar("Fill Course details", "Course Name Cannot be empty!");
      return false;
    }else if(courseDescriptionController.text.trim()==""){
      Get.snackbar("Fill Course details", "Course Description Cannot be empty!");
      return false;
    }else if(courseAuthorController.text.trim()==""){
      Get.snackbar("Fill Course details", "Course Author Cannot be empty!");
      return false;
    }else if(courseImageController.text.trim()==""){
      Get.snackbar("Fill Course details", "Course Image Url Cannot be empty!");
      return false;
    }else{
      return true;
    }
  }


   readCourses() {
     _collection.get(const GetOptions(source: Source.server)).then((QuerySnapshot query){
        courseList.value = [];
        for (var element in query.docs) {
          courseList.add(CourseModel.fromDocumentSnapshot(element));
          s.value = query.metadata.isFromCache?"cache" :"from server";
        }
    }).onError((error, stackTrace) {
        Get.defaultDialog(
            barrierDismissible: true,
            title: "Error",
            middleText: "Please Try Again!",
            onConfirm: readCourses,
             );
    }).catchError((error){
      Get.defaultDialog(
            barrierDismissible: true,
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
