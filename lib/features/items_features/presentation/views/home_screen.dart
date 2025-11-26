import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_cubit.dart';
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_states.dart';
import 'package:auth_with_firebase/features/items_features/presentation/models/item_model.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/CheckOutscreen.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_appbar.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/item_details_screen.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_drawer.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_elevated_button.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
 const  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 252, 181, 208),
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              CustomAppBar()
            ],
            iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 245, 243, 243),        
  ),
            
          ),
           drawer: BlocConsumer<UserCubit,UserState>(
             listener: (BuildContext context, UserState state) { 
               
                      if(state is SignoutState){
             Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignInScreen()),
              );}
             
            else if (state is SignOutfailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
            
         
                      },
             builder: (BuildContext context, state) {  
              final cubit=context.read<UserCubit>();
             return CustomDrawer(cubit: cubit);},
           ),
      body: BlocBuilder<ItemCubit,ItemStates>(
        builder: (BuildContext context, ItemStates state) {  
        return Column(
          children: [
            Expanded(
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      childAspectRatio: 1/1, 
                      crossAxisSpacing:1,
                      mainAxisSpacing: 20),
                      itemCount: items.length,
                       itemBuilder: (BuildContext context, int index) { 
                        return  Column(
                         
                          children: [
                           Flexible(
                             child: InkWell(child: Image.asset(items[index].imgPath,
                             ),
                             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetailsScreen(itemindex:items[index] ,))),
                             ),
                           ),
                           Row(
                            
                               children: [
                                IconButton(onPressed: (){
                                  context.read<ItemCubit>().removeItem(items[index]);
                                 }, icon: Icon(Icons.remove)),
                                 Expanded(child: Text('Price:\n${items[index].price}EG',)),
                                 IconButton(onPressed: (){
                                  context.read<ItemCubit>().addItem(items[index]);
                                 }, icon: Icon(Icons.add)),
                                 
                               ],
                             )
                          ],
                        );
                       },),
            ),CustomElevatedButton(buttonName: 'CheckOut',onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutScreen())),)
          ],
        );},
      ),
      ),
    );
  }
}

