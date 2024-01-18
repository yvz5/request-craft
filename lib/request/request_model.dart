enum HttpMethod { get, post, put, delete, patch }

enum AuthType { none, basic, token, oauth }

enum BodyType { json, form_encoded, x_form, multipart_form }

class Request {
  String name;
  String uuid;
  String description;
  String
      settingsUuid; // we need a default settings object that will be used as a fallback
  HttpMethod method;
  String url;
  Map<String, String> headers;
  BodyType bodyType;
  dynamic body;
  String tests;
  String preRequestScript;
  Auth auth;

  Request({
    required this.name,
    required this.uuid,
    required this.description,
    //todo create uuid
    this.settingsUuid = 'defaultSettings.json.uuidV4',
    required this.method,
    required this.url,
    required this.headers,
    required this.bodyType,
    this.body,
    required this.tests,
    required this.preRequestScript,
    required this.auth,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        name: json['name'],
        uuid: json['uuid'],
        description: json['description'],
        settingsUuid: json['settingsUuid'],
        method: _stringToHttpMethod(json['method']),
        url: json['url'],
        headers: Map<String, String>.from(json['headers']),
        bodyType: _stringToBodyType(json['bodyType']),
        body: json['body'],
        tests: json['tests'],
        preRequestScript: json['preRequestScript'],
        auth: Auth.fromJson(json['auth']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'uuid': uuid,
        'description': description,
        'method': _httpMethodToString(method),
        'url': url,
        'headers': headers,
        'bodyType': _bodyTypeToString(bodyType),
        'body': body,
        'tests': tests,
        'preRequestScript': preRequestScript,
        'auth': auth.toJson(),
      };

  static BodyType _stringToBodyType(String str) {
    return BodyType.values.firstWhere(
        (element) => element.name.toLowerCase() == str.toLowerCase(),
        orElse: () => throw ArgumentError('Invalid BodyType string: $str'));
  }

  static String _bodyTypeToString(BodyType bodyType) {
    return bodyType.name.toLowerCase();
  }

  static HttpMethod _stringToHttpMethod(String str) {
    return HttpMethod.values.firstWhere(
        (element) => element.name.toLowerCase() == str.toLowerCase(),
        orElse: () => throw ArgumentError('Invalid HTTP method string: $str'));
  }

  static String _httpMethodToString(HttpMethod method) {
    return method.name.toLowerCase();
  }
}

class Auth {
  AuthType type;
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
        type: _stringToAuthType(json['type']),
        token: json['token'],
        username: json['username'],
        password: json['password'],
        raw: json['raw'],
      );

  Map<String, dynamic> toJson() => {
        'type': _authTypeToString(type),
        'token': token,
        'username': username,
        'password': password,
        'raw': raw,
      };

  static AuthType _stringToAuthType(String str) {
    return AuthType.values.firstWhere(
      (e) => e.name.toLowerCase() == str.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid Auth type string: $str'),
    );
  }

  static String _authTypeToString(AuthType type) {
    return type.name.toLowerCase();
  }
}
