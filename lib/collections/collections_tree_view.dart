import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_craft/collections/collections_model.dart';
import 'package:request_craft/collections/collection_tree_node.dart';
import 'package:request_craft/collections/collections_provider.dart';

class CollectionsTreeView extends StatefulWidget {
  final List<CollectionModel> collections;
  const CollectionsTreeView({super.key, required this.collections});

  @override
  State<CollectionsTreeView> createState() => _CollectionsTreeViewState();
}

class _CollectionsTreeViewState extends State<CollectionsTreeView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.collections.length,
      itemBuilder: (BuildContext context, int index) {
        return CollectionTreeNode(
          model: widget.collections[index],
          onDelete: () {
            final provider = context.read<CollectionsProvider>();
            provider.deleteAt(index);
          },
        );
      },
    );
  }
}
