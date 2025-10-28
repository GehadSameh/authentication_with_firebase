

import 'dart:io';

import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  File? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();


pickImage()async{
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    profilePic=File(pickedImage.path);
    emit(PickedImageState());
  }

}

  signUp( )async{
    emit(SignUpLoadingState());
    UserModel user=UserModel(
      name: signUpName.text, 
      phone: signUpPhoneNumber.text, 
      email: signUpEmail.text.trim(), 
      password: signUpPassword.text.trim(),
       confirmPassword: confirmPassword.text, 
       profilePic: 'profilePic');
    try{
      // signUP
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password:user.password);
      await FirebaseFirestore.instance.collection('users').add(toMap(user));
      emit(SignUpSucessState());
    }catch(e){
      emit(SignUpfailureState(errorMessage: e.toString()));
    }
    
  }
  

  }

