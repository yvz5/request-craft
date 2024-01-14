import 'package:flutter/material.dart';
import 'package:request_craft/collections/collections_screen.dart';
import 'package:request_craft/constants.dart';
import 'package:request_craft/request/request_screen.dart';
import 'package:split_view/split_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        indicator: const SplitIndicator(
          viewMode: SplitViewMode.Horizontal,
        ),
        activeIndicator: const SplitIndicator(
          viewMode: SplitViewMode.Horizontal,
        ),
        controller: SplitViewController(
            limits: [WeightLimit(min: 0.2), WeightLimit(min: 0.2)],
            weights: [0.2, null]),
        children: const [
          CollectionsScreen(),
          RequestScreen(),
        ],
      ),
    );
  }
}
