import 'package:ekin_app/Product/Widgets/ExpandableFabWidget/expandable_fab.dart';
import 'package:flutter/material.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text("This area is Templates area"),
        ),
        floatingActionButton: CExpandableFabWidget());
  }
}
