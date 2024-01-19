import 'package:request_craft/request/request_model.dart';

class CollectionModel {
  String name;
  String description;
  List<RequestModel> requests;
  List<String> tags;
  String versionControlInfo;
  Map<String, dynamic> sharedVariables;
  int? customOrder;
  String? environmentBinding;
  Map<String, dynamic> customFields;
  int version;

  CollectionModel({
    required this.name,
    required this.description,
    required this.requests,
    required this.tags,
    required this.versionControlInfo,
    required this.sharedVariables,
    this.customOrder,
    this.environmentBinding,
    required this.customFields,
    this.version = 1,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        name: json['name'],
        description: json['description'],
        requests: List.from(json['requests'])
            .map((e) => RequestModel.fromJson(e))
            .toList(),
        tags: List<String>.from(json['tags']),
        versionControlInfo: json['versionControlInfo'],
        sharedVariables: json['sharedVariables'],
        customOrder: json['customOrder'],
        environmentBinding: json['environmentBinding'],
        customFields: json['customFields'],
        version: json['version'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'requests': requests,
        'tags': tags,
        'versionControlInfo': versionControlInfo,
        'sharedVariables': sharedVariables,
        'customOrder': customOrder,
        'environmentBinding': environmentBinding,
        'customFields': customFields,
        'version': version,
      };
}
