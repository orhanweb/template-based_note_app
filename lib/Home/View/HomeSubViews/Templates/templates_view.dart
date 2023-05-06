import 'package:ekin_app/Home/View/HomeSubViews/Templates/new_template_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text("This area is Templates area"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.navigateToPage(const NewTemplateView(),
                type: SlideType.TOP);
          },
          child: const Icon(Icons.add_circle_outline_outlined),
        ));
  }
}
