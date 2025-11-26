
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_cubit.dart';
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_states.dart';
import 'package:auth_with_firebase/features/items_features/presentation/models/item_model.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_appbar.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=context.read<ItemCubit>();
    
    return BlocBuilder<ItemCubit,ItemStates>(
      
      builder: (BuildContext context, state) { 
      return Scaffold(backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 245, 243, 243),        
  ),
            backgroundColor: Color.fromARGB(255, 252, 181, 208),
            title: const Text(
              "Check Out",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: const [
              CustomAppBar(),
            ],
          ),
        body: SingleChildScrollView(
         child: Column(
            children: [
                  ListView.builder(
                              shrinkWrap: true,
                              physics:const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                    itemCount: cubit.itemsList.length,
                    itemBuilder: (context,index){
                    return Card(
                      child: Dismissible(
                        key: ValueKey(cubit.itemsList[index]),
                        onDismissed: (direction) =>cubit.removeItem(cubit.itemsList[index]),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(cubit.itemsList[index].imgPath),
                          ),
                          title:  Text('Product'),
                          subtitle:  Text('${cubit.itemsList[index].price}EG'),
                          trailing: IconButton(onPressed: (){
                            cubit.removeItem(cubit.itemsList[index]);
                          }, icon: const Icon(Icons.remove)),
                        ),
                      ),
                    );
                  }
                  ),
                  
                    CustomElevatedButton(buttonName: 'Pay ${cubit.totalPrice} EG',
        )])
                    
                
                
      
      
         
      
      
         
      )); },
    );
  }
}