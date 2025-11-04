

import 'dart:io';

import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  File? profilePicPath;
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
String? imageUrl;
UserModel ?data;
 String? id;
final supabase = Supabase.instance.client.storage;
final firebase=FirebaseAuth.instance;
pickImage()async{
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    profilePicPath=File(pickedImage.path);
    emit(PickedImageState());
  }

}

uploadImage()async{
  try{
    if (profilePicPath == null) {
   
    return;
  }
   const bucketName = 'store_profile_pic';
  final String filePath = 'images/${DateTime.now().toIso8601String()}.jpg';
  await supabase.from(bucketName).upload(filePath, profilePicPath!);
  final publicUrl = supabase.from(bucketName).getPublicUrl(filePath);

      imageUrl = publicUrl;

      emit(UploadImageState(imageUrl: imageUrl!));
          
  }catch(e){
    emit(SignUpfailureState(errorMessage: e.toString()));
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
       profilePic:imageUrl ?? '',);
    try{
      // signUP
     UserCredential userCred= await firebase.createUserWithEmailAndPassword(email: user.email, password:user.password);
     String uid = userCred.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid)
  .set(toMap(user));
;
      emit(SignUpSucessState());
    }catch(e){
      emit(SignUpfailureState(errorMessage: e.toString()));
    }
    
  }

  signIn() async {
  emit(SignInLoadingState());
  try {
    final respons = await firebase.signInWithEmailAndPassword(
      email: signInEmail.text.trim(),
      password: signInPassword.text.trim(),
    );

    String userid = respons.user!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get();

    if (doc.exists && doc.data() != null) {
      data = UserModel.fromjson(doc.data()!);
      emit(SignInSuccessState());
    } else {
      emit(SignInfailureState(errorMessage: 'User data not found in Firestore.'));
    }
  } catch (e) {
    emit(SignInfailureState(errorMessage: e.toString()));
  }
}

  

  }

