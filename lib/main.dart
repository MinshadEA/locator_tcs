import 'package:flutter/material.dart';
import 'package:locator_tcs/controller/home_screen_controller.dart';
import 'package:locator_tcs/screen/details_screen.dart';
import 'package:locator_tcs/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> HomeScreenController())
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCS Locator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  const HomePageScreen(),
        '/details_screen': (context) => const DetailsScreen(),
      },
     
    );
  }
}

// Navigator.pushNamed(context, '/second');
