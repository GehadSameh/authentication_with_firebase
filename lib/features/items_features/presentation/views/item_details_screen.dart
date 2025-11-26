import 'package:auth_with_firebase/features/items_features/presentation/models/item_model.dart';
import 'package:auth_with_firebase/features/items_features/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
 const  ItemDetailsScreen({super.key, required this.itemindex});
final ItemModel  itemindex;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 245, 243, 243),        
  ),
          backgroundColor: Color.fromARGB(255, 252, 181, 208),
          title: const Text(
            "Description",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomAppBar()
          ],
          
        ),
       
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(widget.itemindex.imgPath)),
             Row(
               children: [
                Column(children: [
                  Text('''Description:
 ${widget.itemindex.description}'''
                    ,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                   
                    overflow: TextOverflow.fade,
                  ),
                  Text('Price : ${widget.itemindex.price} EG'),
                 
                  

                ],)
                 
               ],
             ),
            
                  
            ],
          ),
        ),
      ),
    );
  }
}