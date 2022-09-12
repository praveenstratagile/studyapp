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
          title: const Text('HomeView'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_down_sharp),
            onPressed: () {
              controller.readCourses();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          controller.addCourse(
              courseName: "Flutter",
              description: "Google Flutter",
              author: "Praveen",
              courseImageUrl:
                  "https://uploads-ssl.webflow.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png");
        }),
        body: Obx(() => controller.courseList.isNotEmpty? Container(
          height:Get.height,
          child: ListView.builder(
              itemCount: controller.courseList.length,
              itemBuilder: ((context, index) => Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromARGB(0, 26, 223, 101),
                    child: Column(children: [
                      Text(controller.courseList[index].author ?? "")
                    ]),
                  ))),
        ):
                    const Text("List is Empty")
                    ));
  }
}
