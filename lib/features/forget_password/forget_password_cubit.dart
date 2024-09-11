import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:homez/features/forget_password/forget_password_state.dart';
import 'package:logger/logger.dart';

import 'forget_pass_controllers.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  final dioManager = DioManager();
  final logger = Logger();
  final formKey = GlobalKey<FormState>();
  final controllers = ForgetPasswordControllers();

  Future<void> sendCode({required String phone}) async {
    emit(OtpLoadingState());
    try {
      final response = await dioManager.post(ApiConstants.sendCode,
          data: FormData.fromMap(
            {
              "phone": phone,
            },
          ));

      if (response.statusCode == 200) {
        emit(OtpSuccessState());
        logger.i(response.data["data"]["user"]['phone']);
      } else {
        emit(OtpFailureState(msg: response.data["message"]));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(OtpFailureState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ForgetPasswordFailureState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(ForgetPasswordNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        Map<String, dynamic> json = jsonDecode(e.response?.data);
        emit(ForgetPasswordFailureState(msg: json["status"]));
        break;
      default:
        emit(ForgetPasswordNetworkErrorState());
    }
    logger.e(e);
  }

  @override
  Future<void> close() {
    controllers.phoneController.dispose();
    return super.close();
  }
}
