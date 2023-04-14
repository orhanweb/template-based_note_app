import 'package:dynamic_color/dynamic_color.dart';
import 'package:ekin_app/Core/Constants/color_schemes.dart';
import 'package:ekin_app/Core/Themes/themes.dart';
import 'package:ekin_app/Home/ViewModel/NewRegCubit/new_reg_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Home/View/home.dart';

void main() {
  runApp(const MyApp());
}

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewRegCubit>(create: (context) => NewRegCubit()),
      ],
      child: DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: 'Ekin',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.buildThemeData(
              colorScheme: lightDynamic ?? CShemes.appLightColors),
          darkTheme: AppThemes.buildThemeData(
              colorScheme: darkDynamic ?? CShemes.appDarkColors),
          themeMode: ThemeMode.system,
          home: const MainHome(),
        );
      }),
    );
  }
}
