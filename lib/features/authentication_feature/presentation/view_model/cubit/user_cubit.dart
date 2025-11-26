

import 'dart:io';

import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:auth_with_firebase/features/authentication_feature/data/models/user_model.dart';
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
String? imageUrl;
UserModel ?data;
 String? uid;
final supabase = Supabase.instance.client.storage;
final firebase=FirebaseAuth.instance;
pickImage()async{
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    profilePic=File(pickedImage.path);
    emit(PickedImageState());
  }

}

uploadImage() async {
  emit(SignUpLoadingState());
  try {
    if (profilePic == null) {
      return;
    }

    const bucketName = 'store_profile_pic';
    final fileName = '${profilePic!.path.split('/').last}';
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
      await supabase.from(bucketName).upload(filePath, profilePic!);
    

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
   
    profilePic: imageUrl ?? '',
  );

  try {
    // إنشاء الحساب
    UserCredential userCred = await firebase.createUserWithEmailAndPassword(
      email: user.email,
      password: signUpPassword.text
    );
     await userCred.user!.sendEmailVerification();
     

    uid = userCred.user!.uid;

    // حفظ بيانات المستخدم في Firestore
    await FirebaseFirestore.instance.collection('users').doc(uid).set(toMap(user));
    await userGetData(uid!);
    
   
    emit(SignUpSucessState());
  } on FirebaseAuthException  catch(e) {
    
    emit(SignUpfailureState(errorMessage: e.toString()));
  }
}


  signIn() async {
  emit(SignInLoadingState());
  try {
    
     await firebase.signInWithEmailAndPassword(
      email: signInEmail.text.trim(),
      password: signInPassword.text.trim(),
    );
    final user = firebase.currentUser;
     await user?.reload();

    // 🔹 التحقق من تفعيل الإيميل
    if (user!=null && user.emailVerified) {
       String uid = user.uid;
    
 await    
 userGetData(uid);
emit(SignInSuccessState());
     
    }
   else{
     emit(SignInfailureState(
        errorMessage: 'يرجى تفعيل بريدك الإلكتروني قبل تسجيل الدخول.',
      ));
      
   }
   
   
 
  } on FirebaseAuthException catch (e) {
    String errorMessage = e.toString();

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'The email address is not valid.';
    }
    emit(SignInfailureState(errorMessage: errorMessage));
  }
}

  userGetData(String uid)async{
  final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data() != null) {
      data = UserModel.fromjson(doc.data()!);}

}
 Future signOut()async{
  emit(SignOutLoadingState());
  try{
    await firebase.signOut();
    
    emit(SignoutState());
  }catch(e){
    emit(SignOutfailureState(errorMessage: e.toString()));
  }
  

}
  verfyEmail()async{
    try{
      emit(UserEmailVerificationLoadingState());
      
      await firebase.currentUser!.sendEmailVerification();
      if(firebase.currentUser!.emailVerified){
        emit(UserEmailVerificationSuccessState());
      }

    }catch(e){
emit(UserEmailVerificationFailureState(e.toString()));
    }
  }

resetPassword({required String email})async{
  try{
    emit(ResetPasswordLoadingState());
    await firebase
    .sendPasswordResetEmail(email: email);
    emit(ResetPasswordSuccessState());
  }catch(e){
emit(ResetPasswordfailureState(errorMessage: e.toString()));
  }
}


updateImage() async {
  
  if (profilePic == null) {
    emit(SignUpfailureState(errorMessage: "No image selected."));
    return;
  }

  emit(LoadingImageState()); // لعرض لودر أثناء التحديث

  try {
    const bucketName = 'store_profile_pic';

    // ❗ نفس طريقة اختيار الاسم اللي استخدمتيها قبل كده
    final fileName = profilePic!.path.split('/').last;

    // مسار الصورة داخل الباكيت
    final filePath = 'images/$fileName';

    // ⚠️ رفع الصورة (upsert = true → تحديث إذا موجودة)
    await supabase
        .from(bucketName)
        .upload(filePath, profilePic!, fileOptions: const FileOptions(upsert: true));

    // 👌 الحصول على الرابط بعد الرفع
    final newUrl = supabase.from(bucketName).getPublicUrl(filePath);

    // 🎯 تحديث الصورة داخل Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebase.currentUser!.uid)
        .update({'profilePic': newUrl});

    // 🎉 تحديث البيانات داخل Cubit نفسه
    data = UserModel(
      name: data!.name,
      email: data!.email,
      phone: data!.phone,
    
      profilePic: newUrl,
    );

    // حفظ الرابط في المتغير
    imageUrl = newUrl;

    // نجاح التحديث
    emit(SuccessImageState());
  } catch (e) {
    emit(SignUpfailureState(errorMessage: e.toString()));
  }
}

  }

