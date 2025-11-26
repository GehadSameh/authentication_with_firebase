import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/security_keys.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_cubit.dart';
import 'package:auth_with_firebase/firebase_options.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/home_screen.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_in_screen.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform,);
await Supabase.initialize(
    url: SecurityKeys.url,
    anonKey: SecurityKeys.anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      
      providers: [
        BlocProvider<UserCubit>(
create: (BuildContext context) =>UserCubit(),

    ),
    BlocProvider<ItemCubit>(create: (context)=>ItemCubit())],
      child: MaterialApp(
        color:  Color.fromARGB(255, 255, 255, 255),
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    );}}