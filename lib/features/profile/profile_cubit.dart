import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/core/models/profile_data_model.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:logger/logger.dart';

import '../../core/networking/dio_manager.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final logger = Logger();
  final dioManager = DioManager();
  ProfileDataModel? profileData;

  Future<void> profileInfoData() async {
    emit(ProfileDataLoadingState());
    try {
      final response = await dioManager.get(ApiConstants.showProfile);
      if (response.statusCode == 200) {
        profileData = ProfileDataModel.fromJson(response.data);
        CacheHelper.put(
          key: 'ProfileName',
          value: "${profileData!.data!.user!.fullname}",
        );
        emit(ProfileDataSuccessState());
      } else {
        emit(ProfileDataFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(ProfileDataFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(ProfileDataFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(ProfileDataFailedState(msg: "${e.response?.data}"));
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    try {
      final response = await dioManager.post(
        ApiConstants.logout,
        data: FormData.fromMap(
            {'device': '${CacheHelper.get(key: 'deviceType')}'}),
        header: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        emit(LogOutSuccessState());
      } else {
        emit(LogOutFailedState(msg: response.data["message"]));
      }
    } on DioException catch (e) {
      logoutHandleDioException(e);
    } catch (e) {
      emit(LogOutFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void logoutHandleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(LogOutFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(LogOutFailedState(msg: "${e.response?.data}"));
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }
}
