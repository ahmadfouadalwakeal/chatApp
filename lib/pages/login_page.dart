import 'package:chatapp/Constants.dart';
import 'package:chatapp/pages/Chat_Page.dart';
import 'package:chatapp/pages/Register_page.dart';
import 'package:chatapp/widgets/Custom_Button.dart';
import 'package:chatapp/widgets/Custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snak_bar.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});
  static String id='Login Page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey=GlobalKey();
  String? email,password;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8),
         child: Form(
           key: formkey,
           child: ListView(
             children: [
              SizedBox(height: 75,),
               Image.asset('assets/images/scholar.png',height: 100,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Scholar Chat',
                     style: TextStyle(
                       fontSize: 32,
                       color: Colors.white,
                       fontFamily: 'Pacifico',
                     ),),
                 ],
               ),
               SizedBox(height: 75,),
               Row(
                 children: [
                   Text('LOGIN',
                     style: TextStyle(
                       fontSize: 24,
                       color: Colors.white,
                     ),),
                 ],
               ),
               SizedBox(
                 height: 20,
               ),
               Custom_TextFormField(
                 onchanged: (data){
                   email=data;
                 },
                 hinitText: 'Email',
               ),
               SizedBox(
                 height: 10,
               ),
               Custom_TextFormField(
                 obscureText: true,
                 onchanged: (data){
                   password=data;
                 },
                 hinitText: 'Password',
               ),
               SizedBox(
                 height: 20,
               ),
               CustomButton(
                 onTap: ()async{
                   if(formkey.currentState!.validate()){
                     isLoading=true;
                     setState(() {

                     });
                     try{
                       await loginUser();
                       Navigator.pushNamed(context, ChatPage.id,arguments: email);
                     } on FirebaseAuthException catch(ex){
                       if (ex.code == 'user-not-found') {
                         showSnakBar(context,'user not found');
                       } else if (ex.code == 'wrong-password') {
                         showSnakBar(context, 'wrong password');
                       }
                     }catch(ex){
                       print(ex);
                       showSnakBar(context, 'there was an error');
                     }
                     isLoading=false;
                     setState(() {});
                   }
                 },    text: 'LOGIN',
               ),
               SizedBox(
                 height: 10 ,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('dont\'t have an account ? ',
                   style: TextStyle(
                     color: Colors.white,
                   ),),
                   GestureDetector(
                     onTap: (){
                     Navigator.pushNamed(context, Register_page.id);
                     },
                     child: Text(
                       'Register',
                       style: TextStyle(color: Colors.white),),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user=
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
