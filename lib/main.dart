import 'package:flutter/material.dart';
import 'package:vall/app/app_dependencies.dart';
import 'package:vall/home/home_page.dart';
import 'package:vall/l10n/generated/app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => AppDependencies(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vall',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      );
}
