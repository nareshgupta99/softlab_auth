import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:softlab_auth/network/model/register_model.dart';
import 'package:softlab_auth/network/network_endpoint.dart';
import 'package:softlab_auth/network/network_exception.dart';
import 'package:softlab_auth/network/network_manager.dart';
import 'package:softlab_auth/network/request/network_payload.dart';
import 'package:softlab_auth/network/request/network_request.dart';

class AuthRepository {
  final NetworkManager network;
  AuthRepository({required this.network});

  Future<void> register(AuthRequest payload, Function(Result result, RegisterModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        method: HTTPMethod.post,
        payload: NetworkPayload.registerPaylod(payload: payload),
        endpoint: Endpoints.register,
      );
      try {
        final response = RegisterModel.fromJson(networkResponse);
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> login(AuthRequest payload, Function(Result result, RegisterModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        method: HTTPMethod.post,
        payload: NetworkPayload.loginPaylod(payload: payload),
        endpoint: Endpoints.login,
      );
      try {
        final response = RegisterModel.fromJson(networkResponse);
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> forgotPassword(AuthRequest payload, Function(Result result, RegisterModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        method: HTTPMethod.post,
        payload: NetworkPayload.forgetPasswordPaylod(payload: payload),
        endpoint: Endpoints.forgotPassword,
      );
      try {
        final response = RegisterModel.fromJson(networkResponse);
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> verifyOtp(AuthRequest payload, Function(Result result, RegisterModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        method: HTTPMethod.post,
        payload: NetworkPayload.verifyOtpPaylod(payload: payload),
        endpoint: Endpoints.verifyOtp,
      );
      try {
        final response = RegisterModel.fromJson(networkResponse);
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }

  Future<void> resetPassword(AuthRequest payload, Function(Result result, RegisterModel? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(
        method: HTTPMethod.post,
        payload: NetworkPayload.resetPasswordPayload(payload: payload),
        endpoint: Endpoints.resetPassword,
      );
      try {
        final response = RegisterModel.fromJson(networkResponse);
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }
}

void debugConsole(String? message) {
  if (kDebugMode) {
    log(message ?? "Console null");
  }
}
