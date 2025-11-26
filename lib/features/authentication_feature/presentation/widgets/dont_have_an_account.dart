import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';


class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account ? ',
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 207, 132, 161),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  SignUpScreen(),
                ),
              )
            },
            child: const Text(
              'Sign-up',
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
