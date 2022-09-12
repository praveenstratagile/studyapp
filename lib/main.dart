import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studyapp/app/modules/home/bindings/home_binding.dart';
import 'package:studyapp/app/modules/home/views/home_view.dart';
import 'package:studyapp/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(  GetMaterialApp(
    initialBinding: HomeBinding(),
    home:const HomeView(),
    ));
}
