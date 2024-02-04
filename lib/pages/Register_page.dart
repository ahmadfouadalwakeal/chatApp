import 'package:chatapp/Constants.dart';
import 'package:chatapp/pages/Chat_Page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snak_bar.dart';
import '../widgets/Custom_Button.dart';
import '../widgets/Custom_textfield.dart';

class Register_page extends StatefulWidget {
   Register_page({super.key});

 static String id = 'registerpage';

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
 String ? email;
 String ? password;

 GlobalKey<FormState> formkey=GlobalKey();
 bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
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
                    Text('REGISTER',
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
                      await registerUser();
                      Navigator.pushNamed(context, ChatPage.id);
                    } on FirebaseAuthException catch(ex){
                      if (ex.code == 'weak-password') {
                        showSnakBar(context,'weak-password');
                      } else if (ex.code == 'email-already-in-use') {
                        showSnakBar(context, 'email already exists');
                      }
                    }catch(ex){
                      showSnakBar(context, 'there was an error');
                    }
                    isLoading=false;
                    setState(() {});
                    }
                  },
                  text: 'REGISTER',
                ),
                SizedBox(
                  height: 10 ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have an account ? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    GestureDetector(
                      onTap: (){
                       Navigator.pop(context);
                      },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> registerUser() async {
     UserCredential user=
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
