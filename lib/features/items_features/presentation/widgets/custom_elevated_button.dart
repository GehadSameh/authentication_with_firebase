

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key, required this.buttonName, this.onPressed,
  });
final String buttonName;
final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor:  Color.fromARGB(255, 252, 181, 208),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9)))
    ),
     child:  Text(buttonName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),);
  }
}
