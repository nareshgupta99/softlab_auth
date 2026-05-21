import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:softlab_auth/network/model/register_model.dart';
import 'package:softlab_auth/network/network_endpoint.dart';
import 'package:softlab_auth/network/network_manager.dart';
import 'package:softlab_auth/utils/local_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmittedEvent>(_onLogin);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtPEvent>(_onverifyOtp);
    on<ResetPasswordEvent>(_onresetPassword);
    on<ResetPasswordEvent>(_onresetPassword);
  }

   

  Future<void> _onLogin(LoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final errors = <String, String>{};
      if (event.email.isEmpty) {
        errors['email'] = 'email is required';
      } else if (!event.email.contains('@')) {
        errors['email'] = 'enter valid email';
      }
      if (event.password.isEmpty) {
        errors['password'] = 'Password is required';
      } else if (event.password.length < 6) {
        errors['password'] = 'password must be 6 character long';
      }

      if (errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey]!;
        emit(AuthValidationError(errorTitle: firstKey, error: firstError));
        return;
      }
      // calling the api
      final payload = {
        "email": event.email,
        "password": event.password,
        "role": event.role,
        "device_token": event.deviceToken,
        "type": event.type,
        "social_id": event.socialId,
      };
      NetworkManager network = NetworkManager();
      final networkResponse = await network.loadHTTP(method: HTTPMethod.post, payload: payload, endpoint: Endpoints.login);
      final response = RegisterModel.fromJson(networkResponse);
      LocalStorage.setStringData(key: "token", value: response.token ?? "");

      emit(AuthSuccess(response.message ?? ""));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final errors = <String, String>{};
      if (event.mobile.isEmpty) {
        errors['mobile'] = 'Enter valid Phone Number';
      }
      if (errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey]!;
        emit(AuthValidationError(errorTitle: firstKey, error: firstError));
        return;
      }

      //calling api
      NetworkManager network = NetworkManager();
      final networkResponse = await network.loadHTTP(method: HTTPMethod.post, payload: {"mobile": event.mobile}, endpoint: Endpoints.forgotPassword);
      final response = RegisterModel.fromJson(networkResponse);
      emit(AuthSuccess(response.message ?? ""));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onverifyOtp(VerifyOtPEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final errors = <String, String>{};
      if (event.otp.isEmpty) {
        errors['mobile'] = 'Otp can not be Empty';
      }
      if (errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey]!;
        emit(AuthValidationError(errorTitle: firstKey, error: firstError));
        return;
      }

      //calling api
      NetworkManager network = NetworkManager();
      final networkResponse = await network.loadHTTP(method: HTTPMethod.post, payload: {"otp": event.otp}, endpoint: Endpoints.verifyOtp);
      final response = RegisterModel.fromJson(networkResponse);
      emit(AuthSuccess(response.message ?? ""));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onresetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final errors = <String, String>{};
      if (event.password.isEmpty) {
        errors['password'] = 'password can not be empty';
      } else if (event.cpassword != event.password) {
        errors['cpassword'] = 'password and confirm Password should be match';
      }
      if (errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey]!;
        emit(AuthValidationError(errorTitle: firstKey, error: firstError));
        return;
      }

      //calling api
      NetworkManager network = NetworkManager();
      final payload = {"token": event.token, "password": event.password, "cpassword": event.cpassword};
      final networkResponse = await network.loadHTTP(method: HTTPMethod.post, payload: payload, endpoint: Endpoints.resetPassword);
      final response = RegisterModel.fromJson(networkResponse);
      emit(AuthSuccess(response.message ?? ""));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
