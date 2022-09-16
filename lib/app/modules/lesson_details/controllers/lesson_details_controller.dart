import 'package:get/get.dart';
import 'package:studyapp/app/modules/course_details/model/Lesson_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailsController extends GetxController {
  //TODO: Implement LessonDetailsController

  final count = 0.obs;
  var lesson = LessonModel();
  late YoutubePlayerController videoController;
  var showAppBar = true.obs;
  @override
  void onInit() {
    lesson = Get.arguments;
    // flickManager = FlickManager(
    //   videoPlayerController:
    //       VideoPlayerController.network("https://www.youtube.com/watch?v=WI9uRIzLz1s"),
    // );
    videoController = YoutubePlayerController(
    initialVideoId:YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=WI9uRIzLz1s")??"",
    flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
    ),
);
    super.onInit();
  }

onEnterFullScreen(){
  showAppBar.value = false;
}


onExitFullScreen(){
  showAppBar.value=true;
}

  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
