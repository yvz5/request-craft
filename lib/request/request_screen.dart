import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_craft/request/request_provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<RequestProvider>(
        builder: (context, provider, child) {
          final selectedRequest = provider.selectedRequest;
          if (selectedRequest != null) {
            return Text("Selected request ${selectedRequest.name}");
          }
          return const Text("Select a request");
        },
      ),
    );
  }
}
