// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPasswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPasswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  String? isVerified;

  ResetPasswordModel({this.isVerified});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(isVerified: json["is_verified"]);

  Map<String, dynamic> toJson() => {"is_verified": isVerified};
}
