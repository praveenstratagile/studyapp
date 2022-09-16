import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/lesson_details_controller.dart';

class LessonDetailsView extends GetView<LessonDetailsController> {
  const LessonDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: controller.showAppBar.value
            ? AppBar(
                title: const Text("Lesson"),
                centerTitle: true,
              )
            : null,
        body: videoPlayer()));
  }

  videoPlayer() {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.videoController,
        ),
        onEnterFullScreen: () => controller.onEnterFullScreen(),
        onExitFullScreen: () => controller.onExitFullScreen(),
        builder: (context, player) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.lesson.lessonName ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.blue),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.lesson.description ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 17),
                  textAlign: TextAlign.left,
                ),
              ),
              player,
              //some other widgets
            ],
          );
        });
  }
}
