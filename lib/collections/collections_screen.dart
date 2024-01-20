import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:request_craft/collections/collections_model.dart';
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
                    setState(
                      () {
                        collections.add(CollectionModel(
                          name: "New collection",
                          description: "",
                          requests: [
                            RequestModel(
                                name: "get users",
                                description: '',
                                method: HttpMethod.get,
                                url: 'http://coke.de',
                                headers: {},
                                tests: '',
                                preRequestScript: ''),
                            RequestModel(
                                name: "post users",
                                description: '',
                                method: HttpMethod.post,
                                url: 'http://coke.de',
                                headers: {},
                                tests: '',
                                preRequestScript: ''),
                          ],
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
          const Divider(),
          Expanded(
            child: CollectionsTreeView(
              collections: collections,
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
