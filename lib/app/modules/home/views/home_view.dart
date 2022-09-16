import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:studyapp/app/modules/home/model/course_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(controller.s.value),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_down_sharp),
            onPressed: () {
              controller.readCourses();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            controller.clearTextField();
            Get.bottomSheet(addCourse(),isScrollControlled: true);
          // controller.addCourse(
          //     courseName: "Flutter",
          //     description: "Google Flutter",
          //     author: "Praveen",
          //     courseImageUrl:
          //         "https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png");
        }),
        body: Obx(() => 
        controller.loading.value?
        const Center(child:  CircularProgressIndicator()): 
        controller.courseList.isEmpty?
        const Center(child: Text("Course List is Empty!"),):
        Container(
          padding: const EdgeInsets.only(left:15,right:15),
          height:Get.height,
          // child: ListWheelScrollView(
          //   itemExtent: Get.height/1.5,
          //   children: List.generate(
          //     controller.courseList.length, 
          //     (index) => courseCard(controller.courseList[index])),
            child:ListView.builder(
              itemCount: controller.courseList.length,
              itemBuilder: ((context, index) => courseCard(controller.courseList[index]))),
        )
        ));
  }


  Widget courseCard(CourseModel course){
      return InkWell(
        onTap: (){
          controller.viewCourse(course.courseId!);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            // boxShadow: const [
            //    BoxShadow(
            //     color: Colors.blue,
            //     blurRadius: 5,
            //     spreadRadius: 5,
            //    )
            //   ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                 borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                  ),
                child: Image.network(course.courseImageUrl??"",fit: BoxFit.cover,width: Get.width,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
                )),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text("${course.courseName}",
                    style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 20),
                    textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Author: ${course.author}",
                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                    textAlign: TextAlign.left,
      
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
                              child: Text("${course.description}",
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: ()=>controller.viewCourse(course.courseId!), icon: const Icon(Icons.play_circle_fill_rounded,color: Colors.blue,),),
                  IconButton(onPressed: (){
                    controller.setTextFieldValues(course);
                    Get.bottomSheet(addCourse(update: true,courseId: course.courseId??""),
                  isScrollControlled: true);},
                   icon: const Icon(Icons.edit_note_rounded,color: Colors.blue,),),
                  IconButton(onPressed: ()=>controller.deleteCourse(course.courseId!), icon: const Icon(Icons.delete_rounded,color: Colors.red,),)
                ],
                )
          ]),
        ),
      );
  }

  Widget addCourse({bool update=false,String? courseId}){
    return Container(
      //height: Get.height-Get.statusBarHeight,
      decoration:const  BoxDecoration(
            borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
                ),
          color: Colors.white
        ),
      child:controller.loading.value?
      const CircularProgressIndicator()
      : Wrap(children: [
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
              Text(update?"Update Course Details":"Add New Course",
                          style:const  TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                  )),
              IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.close,color: Colors.white,))
            ],
          ),
        ),    
        textEditor(controller.courseNameController,"Course Name"),
        textEditor(controller.courseDescriptionController,"Course Description"),
        textEditor(controller.courseAuthorController,"Author Name"),
        textEditor(controller.courseImageController,"Course Image Url"),
        createCourseButton(update,courseId),
        const SizedBox(height: 30,)
      ]),
    );
  }

  Widget createCourseButton(bool update,String? courseId){
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ElevatedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top:8,bottom:8),
          width: Get.width,
          child:  Text(update?"Update":"Submit")),
        onPressed: (){
          controller.addCourse(update,courseId: courseId);
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
