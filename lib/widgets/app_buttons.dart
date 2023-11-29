import 'package:flutter/material.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  AppButton({super.key, required this.color, required this.backgroundColor, required this.size, required this.borderColor, this.text, this.icon, this.isIcon = false});

  final Color color;
  final Color backgroundColor;
  final double size;
  final Color borderColor;
  String? text;
  IconData? icon;
  bool isIcon;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Center(
        child: isIcon 
        ? Icon(icon, color: color,)
        : AppText(text: text!, color: color, size: 20,),
      )
    );
  }
}