import 'package:flutter/material.dart';
import 'package:vall/app/app_dependencies.dart';
import 'package:vall/app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => AppDependencies(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Vall',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: appRoutes,
        ),
      );
}
