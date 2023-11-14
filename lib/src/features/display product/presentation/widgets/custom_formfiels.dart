import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.textEditingController,
    this.keyboardType,
    required this.autofocus,
    this.hintText,
    this.labelText,
    this.validator,
    this.maxLines,
    this.minLines,
  });
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool autofocus;
  String? labelText;
  String? hintText;
  int? minLines;
  int? maxLines;
  final String? Function(String? value)? validator;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        validator: widget.validator,
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        autofocus: widget.autofocus,
        decoration: InputDecoration(
            iconColor: Colors.blueGrey,
            hintText: widget.hintText,
            labelText: widget.labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
