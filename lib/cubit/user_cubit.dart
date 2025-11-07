

import 'dart:io';

import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  
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
 String? uid;
final supabase = Supabase.instance.client.storage;
final firebase=FirebaseAuth.instance;
pickImage()async{
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    profilePicPath=File(pickedImage.path);
    emit(PickedImageState());
  }

}
void clearSignUpFields() {
  signUpName.clear();
  signUpPassword.clear();
  confirmPassword.clear();
  signUpPhoneNumber.clear();
  signUpEmail.clear();
  profilePicPath=null;

  emit(UserInitial());
}
void clearSignInFields() {
 
  signInPassword.clear();
 
  signInEmail.clear();


  emit(UserInitial());
}


uploadImage() async {
  emit(SignUpLoadingState());
  try {
    if (profilePicPath == null) {
      return;
    }

    const bucketName = 'store_profile_pic';
    final fileName = '${profilePicPath!.path.split('/').last}';
    final filePath = 'images/$fileName';

    // ✅ 1. Check if file already exists in Supabase storage
    final existingFiles = await supabase.from(bucketName).list(path: 'images');

    final isExist = existingFiles.any((file) => file.name == fileName);

    if (isExist) {
      // ✅ 2. If it exists → just get its public URL
      final publicUrl = supabase.from(bucketName).getPublicUrl(filePath);
      imageUrl = publicUrl;
      
      emit(UploadImageState());
    } else {
      // ✅ 3. If it doesn't exist → upload it
      await supabase.from(bucketName).upload(filePath, profilePicPath!);
    

      final publicUrl = supabase.from(bucketName).getPublicUrl(filePath);
      imageUrl = publicUrl;
      
      emit(UploadImageState());
    }}
   catch (e) {
    emit(SignUpfailureState(errorMessage: e.toString()));
  }
}

  signUp() async {
  emit(SignUpLoadingState());
  UserModel user = UserModel(
    name: signUpName.text,
    phone: signUpPhoneNumber.text,
    email: signUpEmail.text.trim(),
    password: signUpPassword.text.trim(),
    confirmPassword: confirmPassword.text,
    profilePic: imageUrl ?? '',
  );

  try {
    // إنشاء الحساب
    UserCredential userCred = await firebase.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    await userCred.user!.sendEmailVerification();

    uid = userCred.user!.uid;

    // حفظ بيانات المستخدم في Firestore
    await FirebaseFirestore.instance.collection('users').doc(uid).set(toMap(user));
    await userData(uid!);

    
   
    emit(SignUpSucessState());
  } catch (e) {
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
    if (!respons.user!.emailVerified) {
      await firebase.signOut(); // نعمل signOut عشان ما يدخلش التطبيق
      emit(SignInfailureState(
          errorMessage: 'Please verify your email before signing in.'));
      return;
    }

    String uid = respons.user!.uid;
    
 await    
 userData(uid);
emit(SignInSuccessState());
  
  } catch (e) {
    emit(SignInfailureState(errorMessage: e.toString()));
  }
}

 userData(String uid)async{
  final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data() != null) {
      data = UserModel.fromjson(doc.data()!);}

}
signOut()async{
  emit(LoadingState());
  try{
    await firebase.signOut();
    data = null;
    emit(SignoutState());
  }catch(e){
    emit(SignOutfailureState(errorMessage: e.toString()));
  }
  

}
  verfyEmail()async{

  }

  }

