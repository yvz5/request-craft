import 'dart:convert';

class Collection {
  String name;
  String uuid;
  String description;
  List<String> requestUuids;
  List<String> tags;
  String versionControlInfo;
  Map<String, dynamic> sharedVariables;
  int? customOrder;
  Auth collectionLevelAuth;
  String? environmentBinding;
  Map<String, dynamic> customFields;

  Collection({
    required this.name,
    required this.uuid,
    required this.description,
    required this.requestUuids,
    required this.tags,
    required this.versionControlInfo,
    required this.sharedVariables,
    this.customOrder,
    required this.collectionLevelAuth,
    this.environmentBinding,
    required this.customFields,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        name: json['name'],
        uuid: json['uuid'],
        description: json['description'],
        requestUuids: List<String>.from(json['requestUuids']),
        tags: List<String>.from(json['tags']),
        versionControlInfo: json['versionControlInfo'],
        sharedVariables: json['sharedVariables'],
        customOrder: json['customOrder'],
        environmentBinding: json['environmentBinding'],
        customFields: json['customFields'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'uuid': uuid,
        'description': description,
        'requestUuids': requestUuids,
        'tags': tags,
        'versionControlInfo': versionControlInfo,
        'sharedVariables': sharedVariables,
        'customOrder': customOrder,
        'collectionLevelAuth': collectionLevelAuth.toJson(),
        'environmentBinding': environmentBinding,
        'customFields': customFields,
      };
}

  String type;
  String? token;
  String? username;
  String? password;
  String? raw;

  Auth({
    required this.type,
    this.token,
    this.username,
    this.password,
    this.raw,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        type: json['type'],
        token: json['token'],
        username: json['username'],
        password: json['password'],
        raw: json['raw'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'token': token,
        'username': username,
        'password': password,
        'raw': raw,
      };
}
