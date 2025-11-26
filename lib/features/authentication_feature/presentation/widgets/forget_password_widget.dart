import 'package:auth_with_firebase/features/authentication_feature/presentation/screens/forget_password_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.80,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordScreen(),
            ),
          )
        },
        child: const Text(
          'Forget password?',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 102, 156),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
