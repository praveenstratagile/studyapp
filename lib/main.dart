import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:studyapp/app/modules/home/bindings/home_binding.dart';
import 'package:studyapp/app/modules/home/views/home_view.dart';
import 'package:studyapp/app/routes/app_pages.dart';
import 'package:studyapp/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  FirebaseFirestore.instance.settings =
    const Settings(
      sslEnabled: false,
      persistenceEnabled: false);
   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 5656);
 
    
  runApp(  GetMaterialApp(
    initialBinding: HomeBinding(),
    getPages: AppPages.routes,
    initialRoute: AppPages.INITIAL,
    ));
}
