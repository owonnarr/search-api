import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/providers/RepositoriesApiProvider.dart';
import 'package:search/providers/UsersApiProvider.dart';
import 'package:search/screens/SearchScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersApiProvider()),
        ChangeNotifierProvider(create: (_) => RepositoriesApiProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}