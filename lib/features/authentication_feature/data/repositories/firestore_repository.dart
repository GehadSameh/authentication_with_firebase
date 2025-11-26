import 'package:auth_with_firebase/features/authentication_feature/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {

  final firestore=FirebaseFirestore.instance.collection('users');



 Future setUserData( String uid,UserModel user)async{
    await firestore.doc(uid).set(toMap(user));
  }


Future getUserData(String uid)async{
final doc=await firestore.doc(uid).get();

 if (doc.exists) return UserModel.fromjson(doc.data());
    return null;
}



}