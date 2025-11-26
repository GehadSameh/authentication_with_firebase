
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_cubit.dart';
import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_states.dart';
import 'package:auth_with_firebase/features/items_features/presentation/views/CheckOutscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    final cubit=context.read<ItemCubit>();
    return BlocBuilder<ItemCubit,ItemStates>(
      builder: (BuildContext context, state) { 
     return Row(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          bottom: 20,
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(211, 164, 255, 193),
                                  shape: BoxShape.circle),
                              child:  Text(
                               '${cubit.itemsList.length}' ,
                                style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckOutScreen()));
                            },
                            icon: const Icon(Icons.add_shopping_cart)),
                      ],
                    ),
                     Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text('${cubit.totalPrice}' , style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                    )
                  ],
                ); },
    );}}
    
  