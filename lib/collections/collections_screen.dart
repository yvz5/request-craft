import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:request_craft/collections/collections_model.dart';
import 'package:request_craft/collections/collections_provider.dart';
import 'package:request_craft/collections/collections_tree_view.dart';
import 'package:request_craft/request/request_model.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  List<CollectionModel> collections = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    addNewCollection();
                  },
                  child: const Text("New")),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await import();
                },
                child: const Text("Import"),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Consumer<CollectionsProvider>(
              builder: (context, provider, child) {
                return CollectionsTreeView(
                  collections: provider.collections,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> import() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: "Pick a collection",
      allowedExtensions: ['json'],
      type: FileType.custom,
    );

    if (result == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    final provider = context.read<CollectionsProvider>();
    provider.importCollection(result.files.first.path!);
  }

  void addNewCollection() {
    final provider = context.read<CollectionsProvider>();

    provider.addCollection(CollectionModel(
      name: "New collection",
      description: "",
      requests: [
        RequestModel(
            name: "New Request",
            description: '',
            method: HttpMethod.get,
            url: '',
            headers: {},
            tests: '',
            preRequestScript: ''),
      ],
      tags: [],
      versionControlInfo: '',
      sharedVariables: {},
      customFields: {},
    ));
  }
}
