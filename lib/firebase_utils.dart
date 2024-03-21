import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/user_model.dart';

class FirebaseUtils {


 static CollectionReference<TaskModel> getTasksCollection(String uId) {
  return getUsersCollection().doc(uId).collection(TaskModel.collectionName)
      .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) =>
          TaskModel.fromJason(snapshot.data()!),
      toFirestore: (taskModel, options) => taskModel.toJason());
 }

 static Future<void> addTask(TaskModel task,String uId) {
  var collectionRef = getTasksCollection(uId) ;
  var docRef=collectionRef.doc();
  task.id = docRef.id;
  return docRef.set(task);
 }

/* static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
  return getTasksCollection()*//*.orderBy('dateTime',descending: true)*//*.where('dateTime', isEqualTo: DateUtils
      .dateOnly(date)
      .millisecondsSinceEpoch).snapshots();
 }*/

 static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date,String uId) {
  return getTasksCollection(uId).where('dateTime', isEqualTo: DateUtils
      .dateOnly(date)
      .millisecondsSinceEpoch).snapshots();
 }

 static Future<void> deleteTask(TaskModel task,String uId) {
  return getTasksCollection(uId).doc(task.id).delete();
 }

 static Future<void> updateTask(TaskModel task/*String taskId, bool isDone*/,String uId) {
  return getTasksCollection(uId).doc(task.id).update(task.toJason()/*{'isDone': isDone}*/);
 }

 static CollectionReference<MyUser> getUsersCollection(){
 return FirebaseFirestore.instance.collection(MyUser.collectionName).
  withConverter<MyUser>(fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
      toFirestore: (myUser, options) => myUser.toJson());
 }

 static Future<void> addUser(MyUser myUser){
 return getUsersCollection().doc(myUser.id).set(myUser);
 }

 static Future<MyUser?> readUserFromFireStore(String uId)async{
  var docSnapshot=await getUsersCollection().doc(uId).get();
  return docSnapshot.data();
 }

}

/*
static Future<void> updateTask(Movie movie) {
return getMoviesCollection().doc(movie.id.toString()).update(movie.toJson());
}*/
