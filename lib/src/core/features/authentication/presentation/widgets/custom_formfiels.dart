import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.textEditingController,
    this.keyboardType,
    required this.autofocus,
    required this.obsecureText,
    this.hintText,
    this.icondata,
    this.validator,
  });
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool autofocus;
  bool obsecureText;
  Widget? icondata;
  String? hintText;
  final String? Function(String? value)? validator;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.textEditingController,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          obscureText: widget.obsecureText,
          decoration: InputDecoration(
              icon: widget.icondata,
              iconColor: Colors.blueGrey,
              hintText: widget.hintText,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
