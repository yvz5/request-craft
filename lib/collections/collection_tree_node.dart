import 'dart:io';

import 'package:context_menus/context_menus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_craft/collections/collections_model.dart';
import 'package:request_craft/collections/collections_provider.dart';
import 'package:request_craft/request/request_model.dart';
import 'package:request_craft/request/request_provider.dart';

class CollectionTreeNode extends StatefulWidget {
  final CollectionModel model;
  final Function onDelete;

  const CollectionTreeNode(
      {super.key, required this.model, required this.onDelete});

  @override
  State<CollectionTreeNode> createState() => _CollectionTreeNodeState();
}

class _CollectionTreeNodeState extends State<CollectionTreeNode> {
  bool isOpen = false;
  bool isEditing = false;
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildRoot(), isOpen ? _buildRequestNodes() : Container()],
    );
  }

  Widget _buildRequestNodes() {
    List<Widget> children = widget.model.requests
        .map((r) => InkWell(
              onTap: () {
                final provider = context.read<RequestProvider>();
                provider.setSelectedRequest(r);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buildRequestIcon(r.method),
                    Text(r.name),
                  ],
                ),
              ),
            ))
        .toList();

    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  void initState() {
    nameController.text = widget.model.name;
    super.initState();
    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) {
        setNameAndEndEditing(nameController.text);
      }
    });
  }

  void setNameAndEndEditing(String text) {
    setState(() {
      widget.model.name = text;
      isEditing = false;
    });
  }

  Widget buildRoot() {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 42, 182, 247)),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            icon: isOpen
                ? const RotationTransition(
                    // todo try to find a rotation transition
                    turns: AlwaysStoppedAnimation(90 / 360),
                    child: Icon(Icons.chevron_right),
                  )
                : const Icon(Icons.chevron_right),
          ),
          isEditing
              ? Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          focusNode: nameFocusNode,
                        ),
                      ),
                      /* IconButton(
                          onPressed: () {
                            setState(() {
                              widget.model.name = nameController.text;
                              isEditing = false;
                            });
                          },
                          icon: const Icon(Icons.save)),

                      */
                    ],
                  ),
                )
              : GestureDetector(
                  child: Text(widget.model.name),
                  onTap: () {
                    setState(() {
                      isOpen = true;
                    });
                  },
                  onDoubleTap: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                ),
          const Spacer(),
          ContextMenuRegion(
            isEnabled: true,
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "Export",
                  onPressed: () async {
                    await export();
                  },
                ),
                ContextMenuButtonConfig(
                  "Delete",
                  onPressed: () async {
                    widget.onDelete();
                  },
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    );
  }

  _buildRequestIcon(HttpMethod method) {
    switch (method) {
      case HttpMethod.get:
        return const Icon(Icons.download);
      case HttpMethod.post:
        return const Icon(Icons.upload);
      default:
        return const Icon(Icons.plus_one);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> export() async {
    final provider = context.read<CollectionsProvider>();
    String exportData = provider.exportCollection();

    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'export-${widget.model.name}.json',
    );

    if (outputFile == null) {
      // User canceled the picker
      return;
    }
    File file = File(outputFile!);
    file.writeAsStringSync(exportData);
  }
}
