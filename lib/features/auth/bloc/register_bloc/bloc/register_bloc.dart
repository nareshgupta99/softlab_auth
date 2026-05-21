import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {

    on<NextStep>(_onNextStep);
    on<PrevStep>(_onPrevStep);

    on<UpdatePersonalInfo>(_onUpdatePersonal);
    on<UpdateBusinessInfo>(_onUpdateBusiness);
    on<UpdateProof>(_onUpdateProof);
    on<UpdateHours>(_onUpdateHours);

    on<SubmitRegister>(_onSubmit);
  }

  // ---------------- STEP CONTROL ----------------

  void _onNextStep(NextStep event, Emitter<RegisterState> emit) {
    if (state.currentStep < 4) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPrevStep(PrevStep event, Emitter<RegisterState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // ---------------- DATA UPDATE ----------------

  void _onUpdatePersonal(
      UpdatePersonalInfo event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      fullName: event.fullName,
      phone: event.phone,
      email: event.email,
      password: event.password,
      cpassword: event.cpassword,
    ));
  }

  void _onUpdateBusiness(
      UpdateBusinessInfo event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      businessName: event.businessName,
      informalName: event.informalName,
      address: event.address,
      city: event.city,
      state: event.state,
      zipCode: event.zipCode,
    ));
  }

  void _onUpdateProof(UpdateProof event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registrationProof: event.registrationProof));
  }

  void _onUpdateHours(UpdateHours event, Emitter<RegisterState> emit) {
    emit(state.copyWith(businessHours: event.businessHours));
  }

  // ---------------- SUBMIT ----------------

  Future<void> _onSubmit(
      SubmitRegister event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      // 👉 Yaha API call karega
      // final payload = {
      //   ...state.toMap()
      // };

      await Future.delayed(Duration(seconds: 2)); // simulate API

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        currentStep: 4, // success step
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
      ));
    }
  }
}