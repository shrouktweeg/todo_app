import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo/core/services/snack_bar_service.dart';
import 'package:todo/core/utils.dart';
import 'package:todo/models/task_model.dart';


class FirebaseUtils{
  static String uid = "";
 static CollectionReference<TaskModel> getCollectionRef() {
   // we got collection from fire store && convert it to and from fire base.
   return FirebaseFirestore.instance.collection(TaskModel.collectionName)
       .withConverter<TaskModel>(
       fromFirestore:
           (snapshot, _) => TaskModel.fromFirebase(snapshot.data()!),
       toFirestore: (taskModel, _) => taskModel.toFirebase());
 }
 // to add tasks
 static Future<void> addTaskForFireStore(TaskModel taskModel)async {
   CollectionReference<TaskModel> collectionRef=getCollectionRef();
   DocumentReference<TaskModel> docRef=collectionRef.doc(); //create doc & auto generated for id
   taskModel.id=docRef.id; // before sending it
   taskModel.uid=uid;
  return docRef.set(taskModel); //added task
}
// to read data and need to make refresh to show new task
static Stream<QuerySnapshot<TaskModel>> getOneTimeReadFromFireStore(DateTime selectedDate){
  var collectionRef=getCollectionRef().where('selectedDate',isEqualTo:extractDate(selectedDate).millisecondsSinceEpoch );
  return collectionRef.snapshots();
}
// to delete a task
static Future<void>  deleteTask(TaskModel task)async{
  CollectionReference<TaskModel> collectionRef=getCollectionRef();
  DocumentReference<TaskModel> docRef= collectionRef.doc(task.id);
  return docRef.delete();
}
static Future<void> updateIsDone(TaskModel task)async{
  CollectionReference<TaskModel> collectionRef=getCollectionRef();
  DocumentReference<TaskModel> docRef= collectionRef.doc(task.id);
  return docRef.update({
    'isDone':true,
  });
}
static Future<void> updateTask(TaskModel task)async{
  CollectionReference<TaskModel> collectionRef=getCollectionRef();
  DocumentReference<TaskModel> docRef= collectionRef.doc(task.id);
  docRef.update(task.toFirebase());
}

  static Future<void> createAccount(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            'The account already exists for that email.');}
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  static Future<void> signIn(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print(credential.credential?.token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            'Wrong password provided for that user.');
      }
    }
    EasyLoading.dismiss();
  }
}
/*
// to read data and need to make refresh to show new task
static Future<List<TaskModel>> getOneTimeReadFromFireStore(DateTime selectedDate)async{
  var collectionRef=getCollectionRef().where('selectedDate',isEqualTo:extractDate(selectedDate).millisecondsSinceEpoch );

  QuerySnapshot<TaskModel> data=await collectionRef.get();
  List<TaskModel> tasksList=data.docs.map((element)=>element.data()).toList();
  return tasksList;
}
*/