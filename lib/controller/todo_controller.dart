import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  addtoTodoList(String task){
     _user = _auth.currentUser!;
      DateTime tempDate = DateFormat("hh:mm").parse(
       DateTime.now().hour.toString() +
            ":" + DateTime.now().minute.toString());
    var dateFormat = DateFormat("h:mm a"); 

    var time = dateFormat.format(tempDate);
  
     String date = generateDate();
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(_user.uid).collection("todo").doc(date).set({
       "date":date
      });
       users.doc(_user.uid).collection("todo").doc(date).collection("tasks").add({
            "task": task,
            "isTaskCompleted": false,
            "color": DateTime.now().day,
            "time": time
          });
  }


 Stream<QuerySnapshot<Map<String, dynamic>>> gettodos(){
      _user = _auth.currentUser!;
    Stream<QuerySnapshot<Map<String, dynamic>>> todods = FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("todo").snapshots();
    return todods;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks(var docid){
      _user = _auth.currentUser!;
    Stream<QuerySnapshot<Map<String, dynamic>>> tasks = FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("todo").doc(docid).collection("tasks").snapshots();
    return tasks;
  }


  updateTask(var date,var docid,bool value) async{
    _user = _auth.currentUser!;
    
     await FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("todo").doc(date).collection("tasks").doc(docid).set({
            "isTaskCompleted": !value,
          },SetOptions(merge: true));
  }

removeTask(var date,var docid)async{
    _user = _auth.currentUser!;
    try {
   
     await FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("todo").doc(date).collection("tasks").doc(docid).delete();
      print("success");
    } catch (e) {
      print(e.toString());
    }
}





 String generateDate(){
    String tDate;
       var month;
    if (DateTime.now().month == 1) {
      month = "Jan";
    } else if (DateTime.now().month == 2) {
      month = "Feb";
    } else if (DateTime.now().month == 3) {
      month = "Mar";
    } else if (DateTime.now().month == 4) {
      month = "Apr";
    } else if (DateTime.now().month == 5) {
      month = "May";
    } else if (DateTime.now().month == 6) {
      month = "Jun";
    } else if (DateTime.now().month == 7) {
      month = "Jul";
    } else if (DateTime.now().month == 8) {
      month = "Aug";
    } else if (DateTime.now().month == 9) {
      month = "Sep";
    } else if (DateTime.now().month == 10) {
      month = "Oct";
    } else if (DateTime.now().month == 11) {
      month = "Nov";
    } else if (DateTime.now().month == 12) {
      month = "Dec";
    } else {}
tDate = month +" "+ DateTime.now().day.toString() +" "+   DateTime.now().year.toString();
    return tDate;
  }

}