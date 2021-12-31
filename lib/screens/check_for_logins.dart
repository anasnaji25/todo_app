import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/authentication_controller.dart';


class CheckForLogin extends StatefulWidget {
  CheckForLogin({Key? key}) : super(key: key);

  @override
  _CheckForLoginState createState() => _CheckForLoginState();
}

class _CheckForLoginState extends State<CheckForLogin> {

  final authenticationCN = Get.find<AuthenticaionController>();
  

  @override
  void initState() {
    authenticationCN.checkforLOgin();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}