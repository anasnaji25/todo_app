import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/values/app_fonts.dart';
import 'package:intl/intl.dart';

class DrawerWidget extends StatelessWidget {
   DrawerWidget({Key? key}) : super(key: key);
   
  String currentTime(){
        DateTime tempDate = DateFormat("hh:mm").parse(
       DateTime.now().hour.toString() +
            ":" + DateTime.now().minute.toString());
    var dateFormat = DateFormat("h:mm a"); 

    String time = dateFormat.format(tempDate);
     return time;
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: Column(
    // Important: Remove any padding from the ListView.
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                child: DrawerHeader(
                decoration:  BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TODO',style: kloginTextstyle2),
                    Column(
                      children: [
                        Expanded(child: Text(DateTime.now().day.toString()+ "-" +DateTime.now().month.toString()+ "-" +DateTime.now().year.toString(),style: kdateTextstyle2,)),
                        Expanded(child: Text(currentTime(),style: kdateTextstyle2,)),
                      ],
                    )

                  ],
                ),
                  ),
              ),
            ),
          ],
        ),


        Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout",style: klogoutstyle,),
                    Icon(Icons.logout,color: Colors.red,)
                  ],
                ),
              ),
            ),
          ],
        )
    ],
  ),
);
  }
}