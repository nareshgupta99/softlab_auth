part of 'register_bloc.dart';

sealed class RegisterEvent {}

class NextStep extends RegisterEvent {}
class PrevStep extends RegisterEvent {}

class UpdatePersonalInfo extends RegisterEvent {
  final String fullName, phone, email, password, cpassword;
  UpdatePersonalInfo({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.cpassword,
  });
}

class UpdateBusinessInfo extends RegisterEvent {
  final String businessName, informalName, address, city, state, zipCode;

  UpdateBusinessInfo({
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}

class UpdateProof extends RegisterEvent {
  final String registrationProof;
  UpdateProof(this.registrationProof);
}

class UpdateHours extends RegisterEvent {
  final Map<String, List<String>> businessHours;
  UpdateHours(this.businessHours);
}

class SubmitRegister extends RegisterEvent {}
