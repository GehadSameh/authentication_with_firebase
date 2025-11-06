import 'package:auth_with_firebase/cubit/user_cubit.dart';
import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:auth_with_firebase/screens/profile_screen.dart';
import 'package:auth_with_firebase/widgets/custom_form_button.dart';
import 'package:auth_with_firebase/widgets/custom_input_field.dart';
import 'package:auth_with_firebase/widgets/dont_have_an_account.dart';
import 'package:auth_with_firebase/widgets/forget_password_widget.dart';
import 'package:auth_with_firebase/widgets/page_header.dart';
import 'package:auth_with_firebase/widgets/page_heading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit=context.read<UserCubit>();
    return SafeArea(
      child: BlocConsumer<UserCubit,UserState>(
       
        listener: (BuildContext context, state) { 
          if (state is SignInSuccessState) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
   
  } else if (state is SignInfailureState) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
  }
         },
    
         builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key:_formKey,
                      child: Column(
                        children: [
                          const PageHeading(title: 'Sign-in'),
                          //!Email
                          CustomInputField(
                            labelText: 'Email',
                            hintText: 'Your email',
                            controller: cubit.signInEmail, 
                            validate: (value)  =>value ==null? 'please enter your email':null,
                          ),
                          const SizedBox(height: 16),
                          //!Password
                          CustomInputField(
                            validate: (value) =>value ==null? 'please enter password':null,
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            controller:cubit.signInPassword,
                          ),
                          const SizedBox(height: 16),
                          //! Forget password?
                          ForgetPasswordWidget(size: size),
                          const SizedBox(height: 20),
                          state is SignInLoadingState?
                            CircularProgressIndicator():
                          
                          //!Sign In Button
                          CustomFormButton(
                            innerText: 'Sign In',
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){
                              await cubit.signIn();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  
                                  builder: (context) =>  ProfileScreen(),
                                ),
                              );}cubit.clearSignInFields();
                            },
                          ),
                          const SizedBox(height: 18),
                          //! Dont Have An Account ?
                          DontHaveAnAccountWidget(size: size),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );  },
      ),
    );
  }
}
