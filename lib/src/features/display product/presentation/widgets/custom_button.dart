import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onTap,
      this.padding,
      this.backgroundColor,
      this.fontSize,
      this.margin,
      this.text,
      this.textColor,
      this.border});
  void Function()? onTap;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  String? text;
  double? fontSize;
  Color? textColor;
  Color? backgroundColor;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onTap,
        child: Text(
          '$text',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
