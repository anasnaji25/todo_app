import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomWidgets {
  static Widget textField(String title,
      {bool isPassword = false,
      bool isNumber = false,
      Widget? prefix,
      int? length,
      TextEditingController? textController,
      int lines = 1}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            maxLines: lines,
            controller: textController,
            maxLength: length,
            
            inputFormatters: [
              LengthLimitingTextInputFormatter(length),
            ],
            obscureText: isPassword,
            
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
                counterText: '',
                prefix: prefix,
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }
}