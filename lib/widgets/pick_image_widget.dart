import 'package:auth_with_firebase/cubit/user_cubit.dart';
import 'package:auth_with_firebase/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickImageWidget extends StatelessWidget {
   PickImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UserCubit>();
    return BlocBuilder<UserCubit,UserState>(
      builder: (BuildContext context, state) {
      return SizedBox(
        width: 130,
        height: 130,
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: cubit.profilePic!=null?
          FileImage(cubit.profilePic!):
           AssetImage("assets/images/avatar.png"),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () async {
                   cubit.pickImage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                        Icons.camera_alt_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      );  },
    );
  }
}
