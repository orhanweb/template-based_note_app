import 'package:ekin_app/Product/Widgets/ExpandableFabWidget/expandable_fab.dart';
import 'package:flutter/material.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text("This area is Templates area"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
