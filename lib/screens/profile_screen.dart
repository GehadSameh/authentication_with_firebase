import 'package:auth_with_firebase/cubit/user_cubit.dart';
import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override


  Widget build(BuildContext context) {
    var cubit=context.read<UserCubit>();
    
    return BlocConsumer<UserCubit,UserState>(
      listener: (BuildContext context, state) {  
        if(state is SignoutState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
        }else if (state is SignOutfailureState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (BuildContext context, state) {  
      
     return Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 16),
            //! Profile Picture
            CircleAvatar(
              radius: 80,
              backgroundImage: cubit.data?.profilePic != null 
      ? NetworkImage(cubit.data!.profilePic)
               :AssetImage("assets/images/avatar.png"),
              
            ),
            const SizedBox(height: 16),
      
            //! Name
            ListTile(
              title:cubit.data==null?Text('') :Text('Name:${cubit.data!.name}'),
              leading: const Icon(Icons.person),
            ),
            const SizedBox(height: 16),
      
            //! Email
            ListTile(
              title:cubit.data==null?Text('') : Text("Email: ${cubit.data!.email}      "),
              leading: const Icon(Icons.email),
            ),
            const SizedBox(height: 16),
      
            //! Phone number
             ListTile(
              title:cubit.data==null?Text('') : Text('phone: ${cubit.data!.phone}'),
              leading: Icon(Icons.phone),
            ),
            const SizedBox(height: 16),
      
            //! Address
            const ListTile(
              title: Text("Address"),
              leading: Icon(Icons.location_city),
            ),
            const SizedBox(height: 16),

          state is LoadingState?CircularProgressIndicator():  TextButton(onPressed: ()async{
              await cubit.signOut();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));

            }, child: Row(
              children: [
                Icon(Icons.logout_rounded,size: 50,color: Colors.black54,),
              Text('Sign Out',style: TextStyle(color: Colors.black54),),
            ]), 
            )
          ],
        ),
      );},
    );
  }
}
