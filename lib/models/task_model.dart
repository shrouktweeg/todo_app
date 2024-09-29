

import 'package:todo/core/utils.dart';

class TaskModel{
  static const String collectionName='TasksCollection';
  String? id;
  String title='';
  String description='';
  DateTime selectedDate=DateTime.now();
  String? uid;
  bool isDone=false;
  TaskModel({
     this.id,
        required this.title,
        required this.description,
        required this.selectedDate,
    this.uid,
        this.isDone=false
  });
  TaskModel.set(TaskModel taskModel){
    id = taskModel.id;
    uid = taskModel.uid;
    title = taskModel.title;
    description = taskModel.description;
    selectedDate = taskModel.selectedDate;
    isDone = taskModel.isDone;
  }
   Map<String,dynamic>toFirebase()=>
    {
      'id':id,
    'title':title,
    'description':description,
    'selectedDate':extractDate(selectedDate).millisecondsSinceEpoch,
    'isDone':isDone,
    };

  factory TaskModel.fromFirebase(Map<String,dynamic>json)=>
      TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        selectedDate: DateTime.fromMillisecondsSinceEpoch(json['selectedDate']),
        isDone: json['isDone'],
    );
}