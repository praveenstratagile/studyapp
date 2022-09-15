import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:studyapp/app/modules/course_details/model/Lesson_model.dart';

import '../controllers/course_details_controller.dart';

class CourseDetailsView extends GetView<CourseDetailsController> {
  const CourseDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            controller.clearTextField();
            Get.bottomSheet(addLesson(),isScrollControlled: true);
          },
          ),
      body:Obx(() => 
        controller.loading.value?
        const Center(child:  CircularProgressIndicator()): 
        controller.lessonList.isEmpty?
        const Center(child: Text("Lesson List is Empty!"),):
        Container(
          padding: const EdgeInsets.only(left:15,right:15),
          height:Get.height,
            child:ListView.builder(
              itemCount: controller.lessonList.length,
              itemBuilder: ((context, index) => lessonCard(controller.lessonList[index],index))),
        )
        ));
  }


    Widget lessonCard(LessonModel lesson,int index){
      return InkWell(
        onTap:(){
          controller.gotoLessonDetailsPage(lesson);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 10,),
              Text("${(index+1).toString()}. ${lesson.lessonName}",
                  style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 20),
                  textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${lesson.description}",
                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                    textAlign: TextAlign.left,
      
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //IconButton(onPressed: ()=>controller.viewCourse(course.courseId!), icon: const Icon(Icons.play_circle_fill_rounded,color: Colors.blue,),),
                  IconButton(onPressed: (){
                    controller.setTextFieldValues(lesson);
                    Get.bottomSheet(addLesson(update: true,lessonId: lesson.lessonId??""),
                  isScrollControlled: true);},
                   icon: const Icon(Icons.edit_note_rounded,color: Colors.blue,),),
                  IconButton(onPressed: ()=>controller.deleteLesson(lesson.lessonId!), icon: const Icon(Icons.delete_rounded,color: Colors.red,),)
                ],
                )
          ]),
        ),
      );
  }


    Widget addLesson({bool update=false,String? lessonId}){
    return Stack(
      children: [
        Container(
          //height: Get.height-Get.statusBarHeight,
          decoration:const  BoxDecoration(
                borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                    ),
              color: Colors.white
            ),
          child: Wrap(children: [
            Container(
              width: Get.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                    ),
              color: Colors.blue
            ),
              padding: const EdgeInsets.only(top:12,bottom:12),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24,),
                  Text(update?"Update Lesson Details":"Add New Lesson",
                              style:const  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                      )),
                  IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.close,color: Colors.white,))
                ],
              ),
            ),    
            textEditor(controller.lessonNameController,"Lesson Name"),
            textEditor(controller.lessonDescriptionController,"Lesson Description"),
            textEditor(controller.lessonVideoController,"Youtube Video Url"),
            createCourseButton(update,lessonId),
            const SizedBox(height: 30,)
          ]),
        ),
        if(controller.loading.value)
        const Center(child:CircularProgressIndicator())
      ],
    );
  }

  Widget createCourseButton(bool update,String? lessonId){
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ElevatedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top:8,bottom:8),
          width: Get.width,
          child:  Text(update?"Update":"Submit")),
        onPressed: (){
          controller.addLesson(update,lessonId: lessonId);
        },
        ),
      );
  }


  Widget textEditor(TextEditingController controller,String label){
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 0.0),
    )
        ),
      ),
    );
  }
}
