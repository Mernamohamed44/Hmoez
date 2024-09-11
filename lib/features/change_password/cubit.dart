import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:logger/logger.dart';

import 'controller.dart';
import 'states.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final controllers = ChangePasswordControllers();
  bool isCurrentObscure = true;
  bool isObscure = true;
  bool isConObscure = true;
  final dioManager = DioManager();
  final logger = Logger();

  changeCurrentVisibility() {
    isCurrentObscure = !isCurrentObscure;
    emit(ChangeCurrentVisibilityState());
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChangeVisibilityState());
  }

  conChangeVisibility() {
    isConObscure = !isConObscure;
    emit(ConChangeVisibilityState());
  }

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.editPassword,
          data: FormData.fromMap({
            'old_password': controllers.currentPasswordController.text,
            'password': controllers.newPasswordController.text,
            'confirm_password': controllers.confirmPasswordController.text,
          }),
          header: {
            "Accept": "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(ChangePasswordSuccessState());
        } else {
          emit(ChangePasswordFailedState(msg: response.data["message"]));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(ChangePasswordFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ChangePasswordFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(ChangePasswordFailedState(msg: e.response?.data["message"]));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
