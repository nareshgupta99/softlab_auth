import 'package:bloc/bloc.dart';
import 'package:softlab_auth/network/model/register_model.dart';
import 'package:softlab_auth/network/network_endpoint.dart';
import 'package:softlab_auth/network/network_manager.dart';
import 'package:softlab_auth/utils/device_utils.dart';
import 'package:softlab_auth/utils/utils.dart';

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

  void _onUpdatePersonal(UpdatePersonalInfo event, Emitter<RegisterState> emit) {
    emit(state.copyWith(fullName: event.fullName, phone: event.phone, email: event.email, password: event.password, cpassword: event.cpassword));
  }

  void _onUpdateBusiness(UpdateBusinessInfo event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
        businessName: event.businessName,
        informalName: event.informalName,
        address: event.address,
        city: event.city,
        state: event.state,
        zipCode: event.zipCode,
      ),
    );
  }

  void _onUpdateProof(UpdateProof event, Emitter<RegisterState> emit) {
    emit(state.copyWith(registrationProof: event.registrationProof));
  }

  void _onUpdateHours(UpdateHours event, Emitter<RegisterState> emit) {
    emit(state.copyWith(businessHours: event.businessHours));
  }

  // ---------------- SUBMIT ----------------

  Future<void> _onSubmit(SubmitRegister event, Emitter<UserRegisterState> emit) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      NetworkManager network = NetworkManager();
      final deviceToken = await DeviceUtils.getDeviceId();
      final payload = {
        "full_name": state.fullName,
        "email": state.email,
        "phone": state.phone,
        "password": state.password,
        "role": "farmer",
        "business_name": state.businessName,
        "informal_name": state.informalName,
        "address": state.address,
        "city": state.city,
        "state": state.state,
        "zip_code": state.zipCode,
        "registration_proof": state.registrationProof,
        "business_hours": state.businessHours?.map((key, value) {
          return MapEntry(Utils.memonicToDayName(key), value);
        }),
        "device_token": deviceToken,
        "type": "",
        "social_id": "",
      };

      final networkResponse = await network.loadHTTP(method: HTTPMethod.post, payload: payload, endpoint: Endpoints.register);

      final response = RegisterModel.fromJson(networkResponse);

      emit(RegistrationSuccess(response.message ?? ""));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false));
    }
  }
}
