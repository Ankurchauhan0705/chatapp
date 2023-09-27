import 'package:chatapp/widgets/my_button.dart';
import 'package:flutter/material.dart';

class Takeawaymenu extends StatefulWidget {
  const Takeawaymenu({super.key});

  @override
  State<Takeawaymenu> createState() => _TakeawaymenuState();
}

class _TakeawaymenuState extends State<Takeawaymenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(

        children: [
          SizedBox(height: Get.height*0.01,),
          MyButton(title: "Starters", onTap: (){}, height: , width: width)
        ],
      ),
    ),
    );
  }
}
