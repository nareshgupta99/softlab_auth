part of 'register_bloc.dart';

// @immutable
sealed class UserRegisterState {}
class RegisterState extends UserRegisterState  {
  final int currentStep;

  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String cpassword;

  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final String zipCode;

  final String registrationProof;
  final Map<String, List<String>>? businessHours;

  final bool isSubmitting;
  final bool isSuccess;

  RegisterState({
    this.currentStep = 0,
    this.fullName = '',
    this.phone = '',
    this.email = '',
    this.password = '',
    this.cpassword = '',
    this.businessName = '',
    this.informalName = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.registrationProof = '',
    this.businessHours,
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    int? currentStep,
    String? fullName,
    String? phone,
    String? email,
    String? password,
    String? cpassword,
    String? businessName,
    String? informalName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? registrationProof,
    Map<String, List<String>>? businessHours,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return RegisterState(
      currentStep: currentStep ?? this.currentStep,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      cpassword: cpassword ?? this.cpassword,
      businessName: businessName ?? this.businessName,
      informalName: informalName ?? this.informalName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      registrationProof: registrationProof ?? this.registrationProof,
      businessHours: businessHours ?? this.businessHours,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}


class RegistrationSuccess extends UserRegisterState {
  final String message;
  RegistrationSuccess(this.message);
}

class RegistrationFailure extends UserRegisterState {
  final String error;
  RegistrationFailure(this.error);
}

class RegistrationValidationError extends UserRegisterState {
  final String error;
  final String errorTitle;
  RegistrationValidationError({required this.error, required this.errorTitle});
}
