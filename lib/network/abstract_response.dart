class NetworkResponse<T> {
  T? data;
  bool? status;
  String? message;
  NetworkResponse({required this.status, required this.data, required this.message});

  factory NetworkResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return NetworkResponse<T>(message: json["message"], status: json["status"], data: json["data"] == null ? null : fromJsonT(json["data"]));
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T? data) toJsonT) => {"message": message, "status": status, "data": toJsonT(data)};
}
