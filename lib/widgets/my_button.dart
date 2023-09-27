import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double? radius;
  final Color? bgColor;
  final BorderSide? side;
  final TextStyle? txtStyle;
  final bool loading;
  const MyButton(
      {Key? key,
        required this.title,
        required this.onTap,
        this.loading = false,
        required this.height,
        required this.width,
        this.bgColor,
        this.txtStyle,
        this.radius,
        this.side,}
      )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(

              backgroundColor: bgColor ?? Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 25),
                  side: side ?? BorderSide())),
          onPressed: onTap,
          child:


              Center(child: loading==false? Text(
                title,
                style: txtStyle,
              ): LoadingAnimationWidget.prograssiveDots(
                  color: Colors.white, size: 30)
              ),
          //
    ),
    );
  }
}