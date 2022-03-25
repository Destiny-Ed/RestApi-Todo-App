// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    this.status,
    this.message,
    this.tasks,
  });

  String? status;
  String? message;
  List<Task>? tasks;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        status: json["status"],
        message: json["message"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tasks": List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Task {
  Task({
    this.id,
    this.title,
    this.startTime,
    this.endTime,
    this.userId,
    this.reminderPeriod,
  });

  String? id;
  String? title;
  DateTime? startTime;
  DateTime? endTime;
  String? userId;
  DateTime? reminderPeriod;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        userId: json["userId"],
        reminderPeriod: DateTime.parse(json["reminderPeriod"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "startTime": startTime!.toIso8601String(),
        "endTime": endTime!.toIso8601String(),
        "userId": userId,
        "reminderPeriod": reminderPeriod!.toIso8601String(),
      };
}
