import 'package:ekin_app/Core/Constants/string_const.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AtomAlertWidget extends StatelessWidget {
  AtomAlertWidget(
      {super.key, required this.title, this.maxLines, this.maxLength});
  final String title;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: TextField(
          decoration: const InputDecoration(hintText: "Text here"),
          controller: _controller,
          minLines: 1,
          maxLength: maxLength,
          maxLines: maxLines,
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotNullOrNoEmpty) {
                  Navigator.of(context).pop(_controller.text);
                  _controller.clear();
                } else {
                  _controller.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(AppStrings.alertButtonText)),
          CircleAvatar(
              backgroundColor: context.colorScheme.errorContainer,
              child: IconButton(
                  onPressed: () {
                    _controller.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))),
        ]);
  }
}
