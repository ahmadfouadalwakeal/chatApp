import 'package:flutter/material.dart';

class Custom_TextFormField extends StatelessWidget {

   Custom_TextFormField({super.key,this.hinitText,this.onchanged,this.obscureText =false});
  String? hinitText;

  Function(String)? onchanged;

  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      obscureText: obscureText!,
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hinitText,
        hintStyle:TextStyle(
          color: Colors.white,
        ) ,
        enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ) ,
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
    ;
  }
}
