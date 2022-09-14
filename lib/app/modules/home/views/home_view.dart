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
            Get.bottomSheet(addCourse(),isScrollControlled: true);
          // controller.addCourse(
          //     courseName: "Flutter",
          //     description: "Google Flutter",
          //     author: "Praveen",
          //     courseImageUrl:
          //         "https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png");
        }),
        body: Obx(() => 
        controller.courseList.isNotEmpty? 
        Container(
          padding: const EdgeInsets.only(left:15,right:15),
          height:Get.height,
          child: ListWheelScrollView(
            itemExtent: Get.height/2,
            children: List.generate(
              controller.courseList.length, 
              (index) => courseCard(controller.courseList[index])),
            // children:ListView.builder(
            //   itemCount: controller.courseList.length,
            //   itemBuilder: ((context, index) => courseCard(controller.courseList[index]))),
        ))
        :
           const Center(child:  Text("Course List is Empty"))
        ));
  }


  Widget courseCard(CourseModel course){
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[300]
        ),
        child: Column(
          children: [
            ClipRRect(
               borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
                ),
              child: Image.network(course.courseImageUrl??"")),
            Text("${course.courseName}"),
            Text("Created by: ${course.author}"),
            Text("Course details\n\n${course.description}")
        ]),
      );
  }

  Widget addCourse(){
    return Container(
      height: Get.height-Get.statusBarHeight,
      decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
                ),
          color: Colors.blue[100]
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
          child: const Text("Add New Course",
                      style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                              )),
        ),    
        textEditor(controller.courseNameController,"Course Name"),
        textEditor(controller.courseDescriptionController,"Course Description"),
        textEditor(controller.courseAuthorController,"Author Name"),
        textEditor(controller.courseImageController,"Course Image Url"),
        createCourseButton(),
        SizedBox(height: 30,)
      ]),
    );
  }

  Widget createCourseButton(){
    return Padding(
      padding: const EdgeInsets.all(25),
      child: ElevatedButton(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top:8,bottom:8),
          width: Get.width,
          child: const Text("Submit")),
        onPressed: (){
          controller.addCourse();
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
