import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/CheckOutscreen.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.cubit,
  });

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
      builder: (BuildContext context, state) {  
     return Drawer(
       
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
          
           Column(
             children: [
                         
                          UserAccountsDrawerHeader(
                           decoration: BoxDecoration(
                             image: DecorationImage(image: AssetImage('assets/images/bird.jpg',
                             ),fit: BoxFit.cover,
                             ),
                             borderRadius: BorderRadius.all(Radius.circular(20))
                           ),
                           
      
                           currentAccountPicture:state is LoadingImageState?CircularProgressIndicator(): CircleAvatar(
                             backgroundImage:
                             NetworkImage(cubit.data!.profilePic),
                              radius: 70,
                              child: Stack(
       children: [
         Positioned(
           bottom: 5,
           right: 5,
           child: GestureDetector(
             onTap: () async {
               await cubit.pickImage();
            await  cubit.updateImage();
            
             },
             child: Container(
               height: 30,
               width: 30,
               decoration: BoxDecoration(
                 color: 
        Color.fromARGB(255, 252, 181, 208),
                 border: Border.all(color: Colors.white, width: 3),
                 borderRadius: BorderRadius.circular(25),
               ),
               child: Icon(
                   Icons.edit,
                   color: Colors.white,
                   size: 25,
                 ),
               
             ),
           ),
         ),
       ],
                  ),
                             ),
                           accountName: Text(cubit.data!.name,
                     style: TextStyle(
                       color: Color.fromARGB(255, 31, 29, 29),
                     )),
                         accountEmail: Text(cubit.data!.email,
                          style: TextStyle(
                       color: Color.fromARGB(255, 31, 29, 29),)
                         ),
                        ),
                         ListTile(
                   title: const Text("Home"),
                   leading: const Icon(Icons.home),
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                   }),
               ListTile(
                   title: const Text("My products"),
                   leading: const Icon(Icons.add_shopping_cart),
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckOutScreen()));
                   }),
               ListTile(
                   title: const Text("About"),
                   leading: const Icon(Icons.help_center),
                   onTap: () {}),
               ListTile(
                   title: const Text("Logout"),
                   leading: state is SignOutLoadingState?CircularProgressIndicator(): Icon(Icons.exit_to_app),
      
                   onTap: ()async {
                    await cubit.signOut();
                   }),
      
                   
                        
             ],
           ),
           Container(
             margin: const EdgeInsets.only(bottom: 50),
             child: const Text("Developed by Gehad Sameh © 2025",
                 style: TextStyle(fontSize: 16)),
           )
          
         ],
       ),
              );},
    );
  }
}