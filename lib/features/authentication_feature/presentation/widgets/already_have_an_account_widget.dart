
import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Already have an account ? ',
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 207, 132, 161),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen())),
            child: const Text(
              'Log-in',
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 245, 102, 156),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
