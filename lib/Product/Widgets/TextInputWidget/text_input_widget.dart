import 'package:flutter/material.dart';

class TextinputWidget extends StatelessWidget {
  TextinputWidget({Key? key, required this.labelText}) : super(key: key);
  final String labelText;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      minLines: 1,
      controller: _controller,
      decoration: InputDecoration(hintText: labelText),
    );
  }
}
