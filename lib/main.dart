import 'package:flutter/material.dart';
import 'package:request_craft/home/home_screen.dart';
import 'package:request_craft/locator.dart';

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
      home: const HomeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, this.title});

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: SplitView(
//         viewMode: SplitViewMode.Horizontal,
//         indicator: const SplitIndicator(
//           viewMode: SplitViewMode.Horizontal,
//         ),
//         activeIndicator: const SplitIndicator(
//           viewMode: SplitViewMode.Horizontal,
//         ),
//         controller: SplitViewController(
//             limits: [WeightLimit(min: 0.2), null], weights: [0.2, null]),
//         children: [
//           Container(
//               color: const Color(0xFF344955),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("Collections",
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                   Expanded(
//                     child: MyTreeView(),
//                   )
//                 ],
//               )),
//           Container(
//             color: Colors.grey,
//             child: const Center(
//                 child: Text("Request window",
//                     style: TextStyle(color: Colors.white))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyNode {
//   const MyNode({
//     required this.title,
//     this.children = const <MyNode>[],
//   });

//   final String title;
//   final List<MyNode> children;
// }

// class MyTreeView extends StatefulWidget {
//   const MyTreeView({super.key});

//   @override
//   State<MyTreeView> createState() => _MyTreeViewState();
// }

// class _MyTreeViewState extends State<MyTreeView> {
//   // In this example a static nested tree is used, but your hierarchical data
//   // can be composed and stored in many different ways.
//   static const List<MyNode> roots = <MyNode>[
//     MyNode(
//       title: 'Hasan API',
//       children: <MyNode>[
//         MyNode(
//           title: 'get user',
//         ),
//         MyNode(title: 'create user'),
//       ],
//     ),
//     MyNode(
//       title: 'Sac API v2',
//       children: <MyNode>[
//         MyNode(
//           title: 'delete ibine',
//         ),
//         MyNode(title: 'patch obome')
//       ],
//     ),
//   ];

//   // This controller is responsible for both providing your hierarchical data
//   // to tree views and also manipulate the states of your tree nodes.
//   late final TreeController<MyNode> treeController;

//   @override
//   void initState() {
//     super.initState();
//     treeController = TreeController<MyNode>(
//       // Provide the root nodes that will be used as a starting point when
//       // traversing your hierarchical data.
//       roots: roots,
//       // Provide a callback for the controller to get the children of a
//       // given node when traversing your hierarchical data. Avoid doing
//       // heavy computations in this method, it should behave like a getter.
//       childrenProvider: (MyNode node) => node.children,
//     );
//   }

//   @override
//   void dispose() {
//     // Remember to dispose your tree controller to release resources.
//     treeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This package provides some different tree views to customize how
//     // your hierarchical data is incorporated into your app. In this example,
//     // a TreeView is used which has no custom behaviors, if you wanted your
//     // tree nodes to animate in and out when the parent node is expanded
//     // and collapsed, the AnimatedTreeView could be used instead.
//     //
//     // The tree view widgets also have a Sliver variant to make it easy
//     // to incorporate your hierarchical data in sophisticated scrolling
//     // experiences.
//     return TreeView<MyNode>(
//       // This controller is used by tree views to build a flat representation
//       // of a tree structure so it can be lazy rendered by a SliverList.
//       // It is also used to store and manipulate the different states of the
//       // tree nodes.
//       treeController: treeController,

//       // Provide a widget builder callback to map your tree nodes into widgets.
//       nodeBuilder: (BuildContext context, TreeEntry<MyNode> entry) {
//         // Provide a widget to display your tree nodes in the tree view.
//         //
//         // Can be any widget, just make sure to include a [TreeIndentation]
//         // within its widget subtree to properly indent your tree nodes.
//         return MyTreeTile(
//           // Add a key to your tiles to avoid syncing descendant animations.
//           key: ValueKey(entry.node),
//           // Your tree nodes are wrapped in TreeEntry instances when traversing
//           // the tree, these objects hold important details about its node
//           // relative to the tree, like: expansion state, level, parent, etc.
//           //
//           // TreeEntrys are short lived, each time TreeController.rebuild is
//           // called, a new TreeEntry is created for each node so its properties
//           // are always up to date.
//           entry: entry,
//           // Add a callback to toggle the expansion state of this node.
//           onTap: () => treeController.toggleExpansion(entry.node),
//         );
//       },
//     );
//   }
// }

// // Create a widget to display the data held by your tree nodes.
// class MyTreeTile extends StatelessWidget {
//   const MyTreeTile({
//     super.key,
//     required this.entry,
//     required this.onTap,
//   });

//   final TreeEntry<MyNode> entry;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       // Wrap your content in a TreeIndentation widget which will properly
//       // indent your nodes (and paint guides, if required).
//       //
//       // If you don't want to display indent guides, you could replace this
//       // TreeIndentation with a Padding widget, providing a padding of
//       // `EdgeInsetsDirectional.only(start: TreeEntry.level * indentAmount)`
//       child: TreeIndentation(
//         entry: entry,
//         // Provide an indent guide if desired. Indent guides can be used to
//         // add decorations to the indentation of tree nodes.
//         // This could also be provided through a DefaultTreeIndentGuide
//         // inherited widget placed above the tree view.
//         guide: const IndentGuide.connectingLines(indent: 32),
//         // The widget to render next to the indentation. TreeIndentation
//         // respects the text direction of `Directionality.maybeOf(context)`
//         // and defaults to left-to-right.
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
//           child: Row(
//             children: [
//               // Add a widget to indicate the expansion state of this node.
//               // See also: ExpandIcon.
//               FolderButton(
//                 isOpen: entry.hasChildren ? entry.isExpanded : null,
//                 onPressed: entry.hasChildren ? onTap : null,
//                 color: Colors.white,
//               ),
//               Text(entry.node.title,
//                   style: const TextStyle(color: Colors.white)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
