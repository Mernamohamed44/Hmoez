import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:homez/features/register/controller.dart';
import 'package:logger/logger.dart';

part 'profile_details_state.dart';

class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  ProfileDetailsCubit() : super(ProfileDetailsInitial());
  final dioManager = DioManager();
  final formKey = GlobalKey<FormState>();
  final controllers = RegisterControllers();
  final logger = Logger();
  bool isObscure = true;
  bool isConObscure = true;

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      emit(UpdateProfileLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.updateProfile,
          data: FormData.fromMap({
            'fullname': controllers.nameController.text,
            // 'image':'',
            // 'email':''
          }),
          header: {
            "Accept": "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(UpdateProfileSuccessState());
        } else {
          emit(UpdateProfileFailedState(msg: response.data["message"]));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(UpdateProfileFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  Future<void> updatePhone() async {
    if (formKey.currentState!.validate()) {
      emit(UpdatePhoneLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.sendOtpToUpdatePhone,
          data: FormData.fromMap({
            'phone': controllers.phoneController.text,
          }),
          header: {
            "Accept": "application/json",
          },
        );
        if (response.statusCode == 200) {
          emit(UpdatePhoneSuccessState());
        } else {
          emit(UpdatePhoneFailedState(msg: response.data["message"]));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(UpdatePhoneFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(UpdateProfileFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(UpdateProfileFailedState(msg: e.response?.data["message"]));
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
