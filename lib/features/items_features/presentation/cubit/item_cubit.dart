import 'package:auth_with_firebase/features/items_features/presentation/cubit/item_states.dart';
import 'package:auth_with_firebase/features/items_features/presentation/models/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCubit extends Cubit<ItemStates>{
  ItemCubit():super(InitialItemState());

   
    double totalPrice=0;
   List<ItemModel> itemsList=[];
   

addItem(ItemModel item){
  
  totalPrice+=item.price.round();
  itemsList.add(item);
  emit(AddItemState());
}
removeItem(ItemModel item){
 if(itemsList.contains(item)){
  totalPrice-=item.price.round();
  itemsList.remove(item);

  emit(RemoveItemState());}
}
}