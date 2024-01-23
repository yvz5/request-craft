import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_craft/collections/collections_provider.dart';
import 'package:request_craft/home/home_screen.dart';
import 'package:request_craft/locator.dart';
import 'package:request_craft/request/request_provider.dart';

void main() {
  registerServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Craft',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CollectionsProvider>(
            create: (context) => CollectionsProvider(),
          ),
          ChangeNotifierProvider<RequestProvider>(
            create: (context) => RequestProvider(),
          ),
        ],
        child: ContextMenuOverlay(child: const HomeScreen()),
      ),
    );
  }
}
