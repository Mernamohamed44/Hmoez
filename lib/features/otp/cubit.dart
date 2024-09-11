import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:logger/logger.dart';

import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  final dioManager = DioManager();
  final logger = Logger();
  final otpController = TextEditingController();

  Future<void> confirmCode({required String phone}) async {
    emit(OtpLoadingState());
    try {
      final response = await dioManager.post(ApiConstants.confirmCode,
          data: FormData.fromMap(
            {
              "phone": phone,
              "otp": otpController.text,
              'type': 'ios',
              'device_token': 'ssssssssssss'
            },
          ));

      if (response.statusCode == 200) {
        CacheHelper.saveToken(response.data["data"]["user"]['token']);
        // CacheHelper.put(
        //   key: 'userId',
        //   value: "${response.data["data"]['user']['id']}",
        // );
        // CacheHelper.(
        //   key: 'name',
        //   value: "${response.data["data"]['user']['name']}",
        // );
        // CacheHelper.put(
        //   key: 'userType',
        //   value: "${response.data["data"]['user']['type']}",
        // );
        emit(OtpSuccessState());
        logger.i(response.data["data"]["user"]['token']);
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
        emit(OtpFailureState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(OtpFailureState(msg: e.response?.data["message"]));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  Future<void> reSendOtp({required String phone}) async {
    emit(ReSendCodeLoadingState());
    try {
      final response = await dioManager.post(ApiConstants.reSendOtp,
          data: FormData.fromMap({'phone': phone}));

      if (response.statusCode == 200) {
        emit(ReSendCodeSuccessState(msg: "${response.data}"));
      } else {
        emit(ReSendCodeFailedState(msg: "${response.data}"));
      }
    } on DioException catch (e) {
      emit(ReSendCodeFailedState(msg: "${e.response}"));
    } catch (e) {
      emit(ReSendCodeFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  Future<void> checkCode({required String phone}) async {
    emit(OtpLoadingState());
    try {
      final response = await dioManager.post(ApiConstants.checkCode,
          data: FormData.fromMap(
            {
              "phone": phone,
              "otp": otpController.text,
            },
          ));

      if (response.statusCode == 200) {
        //CacheHelper.saveToken(response.data["data"]["user"]['token']);
        // CacheHelper.put(
        //   key: 'userId',
        //   value: "${response.data["data"]['user']['id']}",
        // );
        // CacheHelper.(
        //   key: 'name',
        //   value: "${response.data["data"]['user']['name']}",
        // );
        // CacheHelper.put(
        //   key: 'userType',
        //   value: "${response.data["data"]['user']['type']}",
        // );
        emit(OtpSuccessState());
        logger.i(response.data["data"]["user"]['token']);
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

  Future<void> updatePhone({required String phone}) async {
    emit(OtpLoadingState());
    try {
      final response = await dioManager.post(ApiConstants.updatePhone,
          data: FormData.fromMap(
            {
              "phone": phone,
              "otp": otpController.text,
            },
          ));

      if (response.statusCode == 200) {
        emit(OtpSuccessState());
        logger.i(response.data["data"]["user"]['token']);
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

  @override
  Future<void> close() {
    otpController.dispose();
    return super.close();
  }
}
