import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? token;

  VerifyOtpModel({this.token});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(token: json["token"]);

  Map<String, dynamic> toJson() => {"token": token};
}
