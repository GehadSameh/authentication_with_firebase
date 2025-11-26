// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_cubit.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/view_model/cubit/user_state.dart';
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

 

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener: (BuildContext context, state) { 
        if(state is ResetPasswordSuccessState){
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          backgroundColor: Colors.green,
          content: Text("Please check your email to reset your password.", style: TextStyle(color: Colors.white)),
          duration: Duration(seconds: 5),
        ),);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
        }else if (state is ResetPasswordfailureState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
       },
      builder: (BuildContext context, state) {  
      
    return Scaffold(
        appBar: AppBar(
          title: Text("Reset Password"),
          elevation: 0,
          backgroundColor:Color.fromARGB(255, 252, 181, 208)
          //Color.fromARGB(210, 185, 123, 175),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter your email to rest your password.",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        // we return "null" when something is valid
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Enter a valid email";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration:InputDecoration(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email))),
                     SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                        } 
                        await context.read<UserCubit>().resetPassword(email: emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 252, 181, 208),
                        shape: RoundedRectangleBorder()
                      ),
                      child: state is ResetPasswordLoadingState
                          ? CircularProgressIndicator(
                              color: const Color.fromARGB(255, 252, 181, 208),
                            )
                          : Text(
                              "Reset Password",
                              style: TextStyle(fontSize: 19,
                              color: Colors.black45),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );},
    );
  }
}