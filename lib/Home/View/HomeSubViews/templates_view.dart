import 'package:ekin_app/Product/Widgets/ExpandableFabWidget/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("This area is Templates area"),
        ),
        floatingActionButton: const CExpandableFabWidget());
  }
}
