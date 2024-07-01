import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:logger/logger.dart';

import 'controller.dart';
import 'states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  final dioManager = DioManager();
  final logger = Logger();
  final formKey = GlobalKey<FormState>();
  final controllers = ResetPasswordControllers();
  bool isObscure = true;
  bool isConObscure = true;

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(ResetPasswordLoadingState());
      try {
        final response = await dioManager.post(
          // "${ApiConstants.newResetPasswordUrl}?lang=${CacheHelper.getLang()}",
          "",
          data: FormData.fromMap({
            "new_password": controllers.passwordController.text,
            "new_password_confirmation": controllers.passwordController.text,
          }),
          header: {
            "Authorization": "Bearer ${CacheHelper.getToken()}",
          },
        );
        if (response.statusCode == 200) {
          emit(ResetPasswordSuccessState());
        } else {
          emit(ResetPasswordFailedState(msg: response.data["message"]));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(ResetPasswordFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ResetPasswordFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(ResetPasswordFailedState(msg: e.response?.data["message"]));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  conChangeVisibility() {
    isConObscure = !isConObscure;
    emit(ConChangeVisibilityState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}