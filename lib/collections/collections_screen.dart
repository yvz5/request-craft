import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:request_craft/collections/collections_model.dart';

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
                    setState(
                      () {
                        collections.add(CollectionModel(
                          name: "New collection",
                          description: "",
                          requests: [],
                          tags: [],
                          versionControlInfo: '',
                          sharedVariables: {},
                          customFields: {},
                        ));
                      },
                    );
                  },
                  child: const Text("New")),
              const Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    await import();
                  },
                  child: const Text("Import")),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: collections.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(collections[index].name),
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
      onFileLoading: (p0) {
        print(p0);
      },
    );

    if (result == null) {
      print("olmaz");
      return;
    }

    final File file = File(result.files.first.path!);

    final content = file.readAsStringSync();
    final serialized = CollectionModel.fromJson(jsonDecode(content));

    setState(() {
      collections.add(serialized);
    });
  }
}
