import 'package:get/get.dart';
import 'package:studyapp/app/modules/course_details/model/Lesson_model.dart';

class LessonDetailsController extends GetxController {
  //TODO: Implement LessonDetailsController

  final count = 0.obs;
  var lesson = LessonModel();
  @override
  void onInit() {
    lesson = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
