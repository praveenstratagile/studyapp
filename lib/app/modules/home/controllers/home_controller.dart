import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp/app/modules/course_details/views/course_details_view.dart';
import 'package:studyapp/app/modules/home/model/course_model.dart';
import 'package:studyapp/app/routes/app_pages.dart';

class HomeController extends GetxController with StateMixin{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final CollectionReference _collection;
  
 var s =  ''.obs;
 var courseList = <CourseModel> [].obs;
 TextEditingController courseNameController = TextEditingController();
 TextEditingController courseDescriptionController = TextEditingController();
 TextEditingController courseImageController = TextEditingController();
 TextEditingController courseAuthorController = TextEditingController();
 var loading = false.obs;
 
  @override
  void onInit() {
    _collection = _fireStore.collection('Courses');
    readCourses();
    super.onInit();
  }


 Future<void> addCourse(bool update,{String? courseId}) async {
    if(!validateCourse()){
      return;
    }

    Map<String, dynamic> course = <String, dynamic>{
      "CourseName": courseNameController.text.trim(),
      "Description": courseDescriptionController.text.trim(),
      "Author" : courseAuthorController.text.trim(),
      "CourseImageUrl":courseImageController.text.trim()
    };
    if(update){
        editCourse(course,courseId??"");
    }else{
        createNewCourse(course);
        }
  }

clearTextField(){
  courseNameController.text = "";
  courseDescriptionController.text= "";
  courseAuthorController.text= "";
  courseImageController.text=  "";
}

setTextFieldValues(CourseModel course){
    courseNameController.text = course.courseName??"";
    courseDescriptionController.text=course.description??"";
    courseAuthorController.text = course.author??"";
    courseImageController.text = course.courseImageUrl??"";
}


  createNewCourse(course)async{
    loading.value=true;
          await _collection.doc()
        .set(course)
        .whenComplete(() {
          Get.back();
          Get.snackbar("Successful", "Course added Successfully!");
          readCourses();
        })
        .catchError((e) {
         Get.snackbar("Error", e.toString());
        });
    loading.value=false;
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


   readCourses() async{
    loading.value = true;
    await _collection.get(const GetOptions()).then((QuerySnapshot query){
        courseList.value = [];
        for (var element in query.docs) {
          courseList.add(CourseModel.fromDocumentSnapshot(element));
          s.value = query.metadata.isFromCache?"cache" :"from server";
        }
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
    }).catchError((error){
      Get.snackbar("Error", error.toString());
      
    });
    loading.value=false;
  }

  viewCourse(String courseId){
      Get.toNamed(Routes.COURSE_DETAILS,arguments: courseId);

  }

  editCourse(Map<String, dynamic> course,String courseId)async{
    loading.value =true;
      await _collection.doc(courseId).update(course).whenComplete(()  {
        Get.back();
        Get.snackbar("Success", "Course updated Successfully");
        readCourses();
         
      }).onError((error, stackTrace) {
        Get.snackbar("Failed", error.toString());
      });
    loading.value =false;
  }

  deleteCourse(String courseId)async{
    Get.defaultDialog(title: "Delete?",middleText: "Are you sure want to delete?",
    onConfirm: (() async{
        loading.value=true;
   await  _collection.doc(courseId).delete().whenComplete(() {
        Get.snackbar("Success", "Course Deleted Successfully!");
        readCourses();
    });
    loading.value=false;
    }),
    confirm: Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        
      ),child: const Text("Delete",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
    ),
    onCancel: (){}
    );
  
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
