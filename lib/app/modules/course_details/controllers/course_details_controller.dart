import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyapp/app/modules/course_details/model/Lesson_model.dart';
import 'package:studyapp/app/routes/app_pages.dart';

class CourseDetailsController extends GetxController {
  //TODO: Implement CourseDetailsController
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final CollectionReference _collection;
  var loading = false.obs;
  var lessonList = <LessonModel> [].obs;
 TextEditingController lessonNameController = TextEditingController();
 TextEditingController lessonDescriptionController = TextEditingController();
 TextEditingController lessonVideoController = TextEditingController();




  @override
  void onInit() {
    _collection = _fireStore.collection('Courses').doc(Get.arguments).collection("lessons");
    getLessons();
    super.onInit();
  }
    
     Future<void> addLesson(bool update,{String? lessonId}) async {
    if(!validateLesson()){
      return;
    }

    Map<String, dynamic> lesson = <String, dynamic>{
      "lessonName": lessonNameController.text.trim(),
      "description": lessonDescriptionController.text.trim(),
      "lessonVideoUrl" : lessonVideoController.text.trim(),
    };
    if(update){
        editLesson(lesson,lessonId??"");
    }else{
        createNewLesson(lesson);
        }
  }

    createNewLesson(lesson)async{
    loading.value=true;
          await _collection.doc()
        .set(lesson)
        .whenComplete(() {
          Get.back();
          Get.snackbar("Successful", "Lesson added Successfully!");
          getLessons();
        })
        .catchError((e) {
         Get.snackbar("Error", e.toString());
        });
    loading.value=false;
  }


  getLessons()async{
    loading.value =true;
    await _collection.get().then((QuerySnapshot query) {
       lessonList.value = [];
        for (var element in query.docs) {
          lessonList.add(LessonModel.fromDocumentSnapshot(element));
        }
    });
    loading.value =false;
  }

  clearTextField(){
  lessonNameController.text = "";
  lessonDescriptionController.text= "";
  lessonVideoController.text= "";
}

setTextFieldValues(LessonModel lesson){
    lessonNameController.text = lesson.lessonName??"";
    lessonDescriptionController.text=lesson.description??"";
    lessonVideoController.text = lesson.lessonVideoUrl??"";
}

  validateLesson(){
    if(lessonNameController.text.trim()==""){
      Get.snackbar("Fill Lesson details", "Lesson Name Cannot be empty!");
      return false;
    }else if(lessonDescriptionController.text.trim()==""){
      Get.snackbar("Fill Lesson details", "Lesson Description Cannot be empty!");
      return false;
    }else if(lessonVideoController.text.trim()==""){
      Get.snackbar("Fill Lesson details", "Lesson Video Url Cannot be empty!");
      return false;
    }else{
      return true;
    }
  }

  gotoLessonDetailsPage(LessonModel lesson){
    Get.toNamed(Routes.LESSON_DETAILS,arguments:lesson);
  }


  editLesson(Map<String, dynamic> lesson,String lessonId)async{
    loading.value =true;
      await _collection.doc(lessonId).update(lesson).whenComplete(()  {
        Get.back();
        Get.snackbar("Success", "lesson updated Successfully");
        getLessons();
         
      }).onError((error, stackTrace) {
        Get.snackbar("Failed", error.toString());
      });
    loading.value =false;
  }

  deleteLesson(String lessonId)async{
    Get.defaultDialog(title: "Delete?",middleText: "Are you sure want to delete?",
    onConfirm: (() async{
        loading.value=true;
   await  _collection.doc(lessonId).delete().whenComplete(() {
        Get.snackbar("Success", "Lesson Deleted Successfully!");
        getLessons();
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
