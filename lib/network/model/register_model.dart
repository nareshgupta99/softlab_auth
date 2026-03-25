// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool? success;
  String? message;
  String? token;
  User? user;
  AccountPreference? accountPreference;
  NotificationSettings? notificationSettings;
  bool? isVerified;

  RegisterModel({this.success, this.message, this.token, this.user, this.accountPreference, this.notificationSettings, this.isVerified});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    accountPreference: json["account_preference"] == null ? null : AccountPreference.fromJson(json["account_preference"]),
    notificationSettings: json["notification_settings"] == null ? null : NotificationSettings.fromJson(json["notification_settings"]),
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "user": user?.toJson(),
    "account_preference": accountPreference?.toJson(),
    "notification_settings": notificationSettings?.toJson(),
    "is_verified": isVerified,
  };
}

class AccountPreference {
  String? locale;
  String? timeZone;
  String? currency;

  AccountPreference({this.locale, this.timeZone, this.currency});

  factory AccountPreference.fromJson(Map<String, dynamic> json) =>
      AccountPreference(locale: json["locale"], timeZone: json["time_zone"], currency: json["currency"]);

  Map<String, dynamic> toJson() => {"locale": locale, "time_zone": timeZone, "currency": currency};
}

class NotificationSettings {
  String? notificationSettings;
  String? minBidThreshold;

  NotificationSettings({this.notificationSettings, this.minBidThreshold});

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(notificationSettings: json["notificationSettings"], minBidThreshold: json["minBidThreshold"]);

  Map<String, dynamic> toJson() => {"notificationSettings": notificationSettings, "minBidThreshold": minBidThreshold};
}

class User {
  String? id;
  String? fullName;
  String? email;

  User({this.id, this.fullName, this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(id: json["id"], fullName: json["full_name"], email: json["email"]);

  Map<String, dynamic> toJson() => {"id": id, "full_name": fullName, "email": email};
}
