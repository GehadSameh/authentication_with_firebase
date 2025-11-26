import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  TextEditingController signInEmail = TextEditingController();
 
  TextEditingController signInPassword = TextEditingController();
  
  TextEditingController signUpName = TextEditingController();
  
  TextEditingController signUpPhoneNumber = TextEditingController();
 
  TextEditingController signUpEmail = TextEditingController();
  
  TextEditingController signUpPassword = TextEditingController();
  
  TextEditingController confirmPassword = TextEditingController();
  final firebase=FirebaseAuth.instance;


 Future signUp()async{
    await firebase.createUserWithEmailAndPassword(email: signUpEmail.text.trim(), password: signUpPassword.text);
    
  }

  Future signIn({required String email,required String password})async{
    await firebase.signInWithEmailAndPassword(email: email, password: password);
  }

  Future resetPassword(String email)async{
    await firebase.sendPasswordResetEmail(email: email);

  }

Future sendVerificationEmail()async{
  await firebase.currentUser!.sendEmailVerification();
}
}