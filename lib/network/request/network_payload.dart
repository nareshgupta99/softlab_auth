import 'package:softlab_auth/network/request/network_request.dart';

class NetworkPayload {
  static Map<String, dynamic>? loginPaylod({required AuthRequest payload}) {
    return {
      "email": payload.email,
      "password": payload.password,
      "role": payload.role,
      "device_token": payload.deviceToken,
      "type": payload.type,
      "social_id": payload.socialId,
    };
  }

  static Map<String, dynamic>? registerPaylod({required AuthRequest payload}) {
    return {
      "full_name": payload.fullName,
      "email": payload.email,
      "phone": payload.phone,
      "password": payload.password,
      "role": payload.role,
      "business_name": payload.businessName,
      "informal_name": payload.informalName,
      "address": payload.address,
      "city": payload.city,
      "state": payload.state,
      "zip_code": payload.zipCode,
      "registration_proof": payload.registrationProof,
      "business_hours": payload.businessHours?.map((key, value) {
        return MapEntry(memonicToDayName(key), value);
      }),
      "device_token": payload.deviceToken,
      "type": payload.type,
      "social_id": payload.socialId,
    };
  }

  static Map<String, dynamic>? resetPasswordPayload({required AuthRequest payload}) {
    return {"token": payload.token, "password": payload.password, "cpassword": payload.confirmPassword};
  }

  static Map<String, dynamic>? verifyOtpPaylod({required AuthRequest payload}) {
    return {"otp": payload.otp};
  }

  static Map<String, dynamic>? forgetPasswordPaylod({required AuthRequest payload}) {
    return {"mobile": payload.phone};
  }

  static String memonicToDayName(String name) {
    switch (name) {
      case "M":
        return "mon";
      case "T":
        return "tue";
      case "W":
        return "wed";
      case "Th":
        return "thu";
      case "F":
        return "fri";
      case "S":
        return "sat";
      case "Su":
        return "sun";
      default:
        return "mon";
    }
  }
}
