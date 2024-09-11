import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:logger/logger.dart';

import '../../core/networking/dio_manager.dart';
import 'models.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());


  final logger = Logger();
  final dioManager = DioManager();
  HomeModel? homeData;

  Future<void> getHomeData() async {
    emit(HomeDataLoadingState());
    try {
      final response = await dioManager.get(ApiConstants.showHome);
      if (response.statusCode == 200) {
        homeData = HomeModel.fromJson(response.data);
        emit(HomeDataSuccessState());
      } else {
        emit(HomeDataFailedState(msg: response.data));
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(HomeDataFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(HomeDataFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(HomeNetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(HomeDataFailedState(msg: "${e.response?.data}"));
      default:
        emit(HomeNetworkErrorState());
    }
    logger.e(e);
  }
}
