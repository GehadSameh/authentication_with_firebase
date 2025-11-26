import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_in_screen.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/already_have_an_account_widget.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/custom_form_button.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/custom_input_field.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/custom_phone_field.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/page_heading.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/widgets/pick_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit=context.read<UserCubit>();
    return SafeArea(
      child: BlocConsumer<UserCubit,UserState>(
        
        listener: (BuildContext context, state) { 
          if (state is SignUpSucessState) {
      
   
    
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Your account has been created successfully. Please check your email to verify your account.", style: TextStyle(color: Colors.white)),
          duration: Duration(seconds: 5),
        ),
      );
      
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  SignInScreen()),
      );
   
      
    }
          
          else if  (state is SignUpfailureState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
              content: Text(state.errorMessage,style: TextStyle(color: Colors.black),)));
          }
         },
        builder: (BuildContext context, state) {  
        return SafeArea(
          child: Scaffold(
            
            backgroundColor: const Color(0xffEEF1F3),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                   PageHeading(title: 'Sign-Up',),
                    //! Image
                     PickImageWidget(),
                    const SizedBox(height: 16),
                    //! Name
                    CustomInputField(
                      labelText: 'Name',
                      hintText: 'Your name',
                      isDense: true,
                      controller: cubit.signUpName, validate: (value){
                        if(value==null ||value.isEmpty|| value.length<3){
                          return 'please enter vaild name';
          
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    //!Email
                    CustomInputField(
                      labelText: 'Email',
                      hintText: 'Your email',
                      isDense: true,
                      controller: cubit.signUpEmail, validate: (value){
                        if (value == null || value.trim().isEmpty) return 'Enter Your Email';
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value.trim())) return 'please enter vaild Email';
            return null;
          }
                        
                        
                    ),
                    const SizedBox(height: 5),
                    //! Phone Number
                    Container(
                      width: size.width * 0.9,
                          padding: const EdgeInsets.symmetric(horizontal: 15,),
                      child: Column(
                        children: [
                          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Phone ',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
                          CustomPhoneField()
                        ],
                      ),
                    ),
          
                    // const SizedBox(height: 5),
                    //! Password
                    CustomInputField(
                      labelText: 'Password',
                      hintText: 'Your password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      controller:cubit.signUpPassword, validate: (value) {
                         if (value == null || value.isEmpty) return 'please enter your password';
            if (value.length < 8) return 'the password must be at least 8 character';
            final upper = RegExp(r'[A-Z]');
            final digit = RegExp(r'\d');
            final special = RegExp(r'[!@#\$&*~]');
          
            if (!upper.hasMatch(value)) return 'the password must be at least one capital letter';
            if (!digit.hasMatch(value)) return 'the password must be at least one digit';
            if (!special.hasMatch(value)) return 'the password must be at least one special sympol !@#\$&*~';
            return null;
                      },
                    ),
                    //! Confirm Password
                    CustomInputField(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your password',
                      isDense: true,
                      obscureText: true,
                      suffixIcon: true,
                      controller:cubit.confirmPassword, validate: 
                      (value) {
            if (value == null || value.isEmpty) return 'confirm your password';
            if (value!= cubit.signUpPassword.text) return  'the password isn\'t matched';
            return null;
          },
                    ),
                    const SizedBox(height: 22),
                    //!Sign Up Button
                   state is SignUpLoadingState? CircularProgressIndicator() :CustomFormButton(
                      innerText: 'Sign up',
                      onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            
              await cubit.uploadImage();
              await cubit.signUp();
              
          
              
            }
                        
          }),
                    const SizedBox(height: 18),
                    //! Already have an account widget
                    const AlreadyHaveAnAccountWidget(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );},
      ),
    );
  }
}
