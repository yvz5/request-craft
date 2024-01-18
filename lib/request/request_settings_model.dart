class RequestSettings {
  bool followRedirection;
  int timeoutSeconds;
  bool allowInsecureCertificates;
  bool validateCertificates;
  bool autoRetry;
  int retryCount;
  int retryIntervalSeconds;

  RequestSettings({
    required this.followRedirection,
    required this.timeoutSeconds,
    required this.allowInsecureCertificates,
    required this.validateCertificates,
    required this.autoRetry,
    required this.retryCount,
    required this.retryIntervalSeconds,
  });

  factory RequestSettings.fromJson(Map<String, dynamic> json) =>
      RequestSettings(
        followRedirection: json['followRedirection'] ?? true,
        timeoutSeconds: json['timeoutSeconds'] ?? 30,
        allowInsecureCertificates: json['allowInsecureCertificates'] ?? false,
        validateCertificates: json['validateCertificates'] ?? true,
        autoRetry: json['autoRetry'] ?? false,
        retryCount: json['retryCount'] ?? 3,
        retryIntervalSeconds: json['retryIntervalSeconds'] ?? 5,
      );

  Map<String, dynamic> toJson() => {
        'followRedirection': followRedirection,
        'timeoutSeconds': timeoutSeconds,
        'allowInsecureCertificates': allowInsecureCertificates,
        'validateCertificates': validateCertificates,
        'autoRetry': autoRetry,
        'retryCount': retryCount,
        'retryIntervalSeconds': retryIntervalSeconds,
      };
}
