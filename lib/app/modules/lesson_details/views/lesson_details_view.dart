import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lesson_details_controller.dart';

class LessonDetailsView extends GetView<LessonDetailsController> {
  const LessonDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.lesson.lessonName??"",
                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.blue),
                    textAlign: TextAlign.left,
                ),
              ),
        Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.lesson.description??"",
                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
                    textAlign: TextAlign.left,
                ),
              ),
      ],)
    );
  }
}
