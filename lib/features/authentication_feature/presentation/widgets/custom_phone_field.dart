import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatelessWidget {
   const CustomPhoneField({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<UserCubit,UserState>(
      builder: (BuildContext context, state) {  
        final UserCubit cubit=context.read();
      return IntlPhoneField(
        
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.always,
        
        
        decoration: InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        initialCountryCode: 'EG', 
        
       
        
        validator: (phone) {
          if (phone == null || phone.number.isEmpty) {
            return 'Please enter your phone number';
          }
          if (phone.number.length < 9) {
            return 'Invalid phone number';
          }
          return null;
        },
        onSaved: (phone) {
          cubit.signUpPhoneNumber.text= phone!.completeNumber;
        },
        
      );},
    );
  }
}
