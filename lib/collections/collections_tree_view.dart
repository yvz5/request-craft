import 'package:arborio/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:request_craft/collections/collections_model.dart';
import 'package:request_craft/request/request_model.dart';
import 'package:uuid/uuid.dart';

class CollectionsTreeView extends StatefulWidget {
  final List<CollectionModel> collections;
  const CollectionsTreeView({super.key, required this.collections});

  @override
  State<CollectionsTreeView> createState() => _CollectionsTreeViewState();
}

class _CollectionsTreeViewState extends State<CollectionsTreeView> {
  final List<TreeNode<dynamic>> treeRoot = [];

  @override
  Widget build(BuildContext context) {
    treeRoot.clear();

    for (var element in widget.collections) {
      final node = TreeNode<dynamic>(Key(const Uuid().v8()), element);

      for (var req in element.requests) {
        node.children.add(TreeNode(Key(const Uuid().v8()), req));
      }

      treeRoot.add(node);
    }

    return _treeView();
  }

  TreeView<dynamic> _treeView() => TreeView(
        builder: (
          context,
          node,
          isSelected,
          expansionAnimation,
          select,
        ) {
          if (node.data is CollectionModel) {
            return Text(node.data.name);
          } else {
            return InkWell(
              enableFeedback: false,
              canRequestFocus: false,
              onTap: () => select(node),
              // ignore: use_decorated_box
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey.withOpacity(.3) : null,
                ),
                child: Row(
                  children: [
                    _getIcon(node.data.method),
                    const SizedBox(width: 16),
                    Text(node.data.name),
                  ],
                ),
              ),
            );
          }
        },
        nodes: treeRoot,
        expanderBuilder: (context, node, animationValue) => RotationTransition(
          turns: animationValue,
          child: const Icon(Icons.chevron_right_outlined),
        ),
      );

  Widget _getIcon(HttpMethod method) {
    switch (method) {
      case HttpMethod.get:
        return const Icon(Icons.download_outlined);
      case HttpMethod.post:
        return const Icon(Icons.upload);
      default:
        return const Icon(Icons.chevron_right_sharp);
    }
  }
}
