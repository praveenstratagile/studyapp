// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LessonModel {
  String? lessonId;
  String? lessonName;
  String? description;
  String? lessonVideoUrl;
  LessonModel({
    this.lessonId,
    this.lessonName,
    this.description,
    this.lessonVideoUrl,
  });

  LessonModel copyWith({
    String? lessonId,
    String? lessonName,
    String? description,
    String? lessonVideoUrl,
  }) {
    return LessonModel(
      lessonId: lessonId ?? this.lessonId,
      lessonName: lessonName ?? this.lessonName,
      description: description ?? this.description,
      lessonVideoUrl: lessonVideoUrl ?? this.lessonVideoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessonId': lessonId,
      'lessonName': lessonName,
      'description': description,
      'lessonVideoUrl': lessonVideoUrl,
    };
  }

  factory LessonModel.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {
    Map<String,dynamic> map = doc.data() as Map<String,dynamic>;
    return LessonModel(
      lessonId: doc.id,
      lessonName: map['lessonName'] != null ? map['lessonName'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      lessonVideoUrl: map['lessonVideoUrl'] != null ? map['lessonVideoUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonModel.fromJson(String source) => LessonModel.fromDocumentSnapshot(json.decode(source) as QueryDocumentSnapshot<Object?>);

  @override
  String toString() {
    return 'LessonModel(lessonId: $lessonId, lessonName: $lessonName, description: $description, lessonVideoUrl: $lessonVideoUrl)';
  }

  @override
  bool operator ==(covariant LessonModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lessonId == lessonId &&
      other.lessonName == lessonName &&
      other.description == description &&
      other.lessonVideoUrl == lessonVideoUrl;
  }

  @override
  int get hashCode {
    return lessonId.hashCode ^
      lessonName.hashCode ^
      description.hashCode ^
      lessonVideoUrl.hashCode;
  }
}
