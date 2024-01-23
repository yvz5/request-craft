import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:request_craft/collections/collections_model.dart';

class CollectionsProvider with ChangeNotifier {
  final List<CollectionModel> _collections = [];
  List<CollectionModel> get collections => _collections;

  void addCollection(CollectionModel collectionModel) {
    _collections.add(collectionModel);

    notifyListeners();
  }

  void importCollection(String path) {
    final File file = File(path);

    final content = file.readAsStringSync();
    // todo validation version could be used for this. Use collection name as unique identifier
    final serialized = CollectionModel.fromJson(jsonDecode(content));

    addCollection(serialized);
  }

  void deleteAt(int index) {
    _collections.removeAt(index);

    notifyListeners();
  }

  String exportCollection() {
    return jsonEncode(_collections.first.toJson());
  }
}
