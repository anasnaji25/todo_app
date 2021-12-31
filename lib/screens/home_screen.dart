import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/values/app_fonts.dart';
import 'package:todo_app/widgets/drawer_widget.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final todoController = Get.find<TodoController>();
late String todoTask;
  // List testlist = [
  //  {
  //    "date": "Feb 21 2016",
  //    "todos": [
  //      {"task":"complete assignmet","bool": false,"color": Colors.red},
  //      { "task":"bangalore trip","bool": false,"color": Colors.red}
  //    ],


  //  },
  //  {
  //    "date": "Feb 22 2016",
  //    "todos": [
  //    {"task":"complete assignmet","bool": false,"color": Colors.yellow},
  //      {"task":"pune trip","bool": false,"color": Colors.yellow},
  //      {"task":"job complete","bool": false,"color": Colors.yellow},
  //     { "task":"ice coffeee","bool": false,"color": Colors.yellow},
  //     { "task":"rain dance","bool": false,"color": Colors.yellow}
  //    ],

  //  }
  // ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST"),
        centerTitle: true,
      ),
      endDrawer:DrawerWidget(),
      body: Container(
         height: size.height,
         width: size.width,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: todoController.gettodos(),
          builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("Something Went wrong"),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 2),
                      child: Text(snapshot.data!.docs[index].id,style: kdatetextStyle,),
                    ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(5,0,5,5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: todoController.getTasks(snapshot.data!.docs[index].id),
                            builder: (context, snapshot2) {
                                if(snapshot.hasError){
            return Center(
              child: Text("Something Went wrong"),
            );
          }else if(snapshot2.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{   
             return ListView.builder(
                                   shrinkWrap: true,
                                   itemCount: snapshot2.data!.docs.length,
                                itemBuilder: (context,j){
                                  return Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        color: snapshot2.data!.docs[j]["color"].isOdd && snapshot2.data!.docs[j]["color"] < 5 ? Colors.yellow : snapshot2.data!.docs[j]["color"].isEven && snapshot2.data!.docs[j]["color"] < 5 ? Colors.red :Colors.orange  ,
                                        height: 40,
                                      ),
                                      Container(
                                        width: size.width-50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.fromLTRB(15,10,0,10),
                                              child: Text(snapshot2.data!.docs[j]["task"],style:snapshot2.data!.docs[j]["isTaskCompleted"]? ktodoListdissablesstyle: ktodoListstyle,),
                                            ),
                                            Row(
                                              children:[
                                                Text(snapshot2.data!.docs[j]["time"],style: snapshot2.data!.docs[j]["isTaskCompleted"]? ktodoListdissablesstyle: ktodoListstyle2,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                      onTap: () {
                                     
                                     snapshot2.data!.docs[j]["isTaskCompleted"] == false ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>  _taskCompleteOrDelete(context,snapshot.data!.docs[index].id,snapshot2.data!.docs[j].id,snapshot2.data!.docs[j]["isTaskCompleted"]),
                                          ) : todoController.updateTask(snapshot.data!.docs[index].id,snapshot2.data!.docs[j].id,snapshot2.data!.docs[j]["isTaskCompleted"]);
                                        
                                      },
                                      child: Container(
                                         height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: snapshot2.data!.docs[j]["isTaskCompleted"] ?  Colors.teal : Colors.white,
                                          border: Border.all(
                                            color: Colors.teal
                                          )
                                        ),
                                        child: snapshot2.data!.docs[j]["isTaskCompleted"]
                                            ? Icon(
                                                Icons.check,
                                                size: 30.0,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.check,
                                                size: 30.0,
                                                color: Colors.white,
                                              )
                                      ),
                                        )
                                              ]
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                              });
          }

                            }
                          ),
                        ),
                      ),
                    )
                  ],
               );
              });
          }
          }
        ),
      ),

        floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: (){
           showDialog(
              context: context,
              builder: (BuildContext context) =>  _addToTodoList(context),
            );

          
        },
      ),
    );
  }

  

 Widget _addToTodoList(BuildContext context) {
  return  AlertDialog(
    title: const Text('Add TODO'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
           Container(
             height: 45,
             width: 350,
             child: TextField(
              //  controller: customernameCn,
               decoration: InputDecoration(
                 hintText: 'Enter here',
                 contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                 hintStyle: TextStyle(
                   color: Colors.grey,
                 ),
                 filled: true,
                 fillColor: Colors.white70,
                 enabledBorder: OutlineInputBorder(
                   borderRadius:
                       BorderRadius.all(Radius.circular(30.0)),
                   borderSide:
                       BorderSide(color: Colors.black38, width: 1),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius:
                       BorderRadius.all(Radius.circular(30.0)),
                   borderSide: BorderSide(color: Colors.black38),
                 ),
               ),
               onChanged: (value) {
                 todoTask = value;
               },
             ),
           ),
       
      ],
    ),
    actions: <Widget>[
       new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
      new FlatButton(
        onPressed: () {
          todoController.addtoTodoList(todoTask);
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Add'),
      ),
    ],
  );
}



 Widget _taskCompleteOrDelete(BuildContext context,var vdate,var docid,bool value) {
  return  AlertDialog(
    title: const Text('Choose'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Text("Task Completed / Remove Task")
       
      ],
    ),
    actions: <Widget>[
       new FlatButton(
        onPressed: () {
          todoController.removeTask(vdate, docid);
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Remove Task'),
      ),
      new FlatButton(
        onPressed: () {
          todoController.updateTask(vdate, docid, value);
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Completed'),
      ),
    ],
  );
}
}