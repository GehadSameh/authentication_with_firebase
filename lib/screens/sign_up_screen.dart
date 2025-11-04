import 'package:auth_with_firebase/cubit/user_cubit.dart';
import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/screens/profile_screen.dart';
import 'package:auth_with_firebase/widgets/already_have_an_account_widget.dart';
import 'package:auth_with_firebase/widgets/custom_form_button.dart';
import 'package:auth_with_firebase/widgets/custom_input_field.dart';
import 'package:auth_with_firebase/widgets/page_header.dart';
import 'package:auth_with_firebase/widgets/page_heading.dart';
import 'package:auth_with_firebase/widgets/pick_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<UserCubit>();
    return SafeArea(
      child: BlocConsumer<UserCubit,UserState>(
        
        listener: (BuildContext context, state) { 
          if(state is SignUpSucessState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('sucess')));
          }
           else if  (state is SignUpfailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
         },
        builder: (BuildContext context, state) {  
        return Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: SingleChildScrollView(
            child: Form(
              key: context.read<UserCubit>().signUpFormKey,
              child: Column(
                children: [
                  const PageHeader(),
                  const PageHeading(title: 'Sign-up'),
                  //! Image
                   PickImageWidget(),
                  const SizedBox(height: 16),
                  //! Name
                  CustomInputField(
                    labelText: 'Name',
                    hintText: 'Your name',
                    isDense: true,
                    controller: context.read<UserCubit>().signUpName,
                  ),
                  const SizedBox(height: 16),
                  //!Email
                  CustomInputField(
                    labelText: 'Email',
                    hintText: 'Your email',
                    isDense: true,
                    controller: context.read<UserCubit>().signUpEmail,
                  ),
                  const SizedBox(height: 16),
                  //! Phone Number
                  CustomInputField(
                    labelText: 'Phone number',
                    hintText: 'Your phone number ex:01234567890',
                    isDense: true,
                    controller: context.read<UserCubit>().signUpPhoneNumber,
                  ),
                  const SizedBox(height: 16),
                  //! Password
                  CustomInputField(
                    labelText: 'Password',
                    hintText: 'Your password',
                    isDense: true,
                    obscureText: true,
                    suffixIcon: true,
                    controller: context.read<UserCubit>().signUpPassword,
                  ),
                  //! Confirm Password
                  CustomInputField(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Your password',
                    isDense: true,
                    obscureText: true,
                    suffixIcon: true,
                    controller: context.read<UserCubit>().confirmPassword,
                  ),
                  const SizedBox(height: 22),
                  //!Sign Up Button
                 state is SignUpLoadingState? CircularProgressIndicator() :CustomFormButton(
                    innerText: 'Signup',
                    onPressed: () async{
                   await   context.read<UserCubit>().signUp();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    },
                  ),
                  const SizedBox(height: 18),
                  //! Already have an account widget
                  const AlreadyHaveAnAccountWidget(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );},
      ),
    );
  }
}
