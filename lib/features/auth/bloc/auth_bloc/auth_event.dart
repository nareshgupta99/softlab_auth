part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  final String type;
  final String socialId;
  final String deviceToken;
  LoginSubmittedEvent({
    required this.email,
    required this.password,
    required this.role,
    required this.type,
    required this.socialId,
    required this.deviceToken,
  });
}

class SendOtpEvent extends AuthEvent {
  final String mobile;
  SendOtpEvent(this.mobile);
}

class VerifyOtPEvent extends AuthEvent {
  final String otp;
  VerifyOtPEvent(this.otp);
}

class ResetPasswordEvent extends AuthEvent {
  final String token;
  final String password;
  final String cpassword;

  ResetPasswordEvent({required this.token, required this.password, required this.cpassword});
}

class RegisterEvent1 extends AuthEvent {
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String cpassword;

  RegisterEvent1({required this.fullName, required this.phone, required this.password, required this.cpassword, required this.email});
}

class RegisterEvent2 extends AuthEvent {
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final String zipCode;

  RegisterEvent2({
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}

class RegisterEvent3 extends AuthEvent {
  final String registrationProof;
  RegisterEvent3(this.registrationProof);
}

class RegisterEvent4 extends AuthEvent {
 final Map<String, List<String>>? businessHours;
  RegisterEvent4(this.businessHours);
}
