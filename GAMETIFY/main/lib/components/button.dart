import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final String text;
  const MyButton ({
    super.key,
    required this.text,
  })

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration : BoxDecoration(color: Colors.fromARGB(109,135,81,77), borderRadius: BorderRadius.Circular(40),),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: mainAxisAlignment.center,
        children:[
          //text
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(width: 10),

          //icon
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

