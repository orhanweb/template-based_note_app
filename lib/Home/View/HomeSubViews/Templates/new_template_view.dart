import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class NewTemplateView extends StatefulWidget {
  const NewTemplateView({super.key});

  @override
  State<NewTemplateView> createState() => _NewTemplateViewState();
}

class _NewTemplateViewState extends State<NewTemplateView> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Template Name.."),
          )),
      floatingActionButton: const ExpandableFab(children: []),
    );
  }
}
