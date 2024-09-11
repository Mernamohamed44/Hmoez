import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/core/networking/api_constants.dart';
import 'package:homez/core/networking/dio_manager.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'controller.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  final formKey = GlobalKey<FormState>();
  final dioManager = DioManager();
  final logger = Logger();
  final controllers = LoginControllers();
  bool isObscure = true;
  bool isRemember = true;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final response = await dioManager.post(
          ApiConstants.login,
          data: FormData.fromMap({
            "password": controllers.passwordController.text,
            'device_token': '${CacheHelper.get(key: 'deviceToken')}',
            'type': '${CacheHelper.get(key: 'deviceType')}',
            "phone": controllers.phoneController.text,
          }),
        );
        // Map<String, dynamic> json = jsonDecode(response.data);
        if (response.statusCode == 200) {
          emit(LoginSuccessState());
          CacheHelper.saveToken("${response.data['data']['user']['token']}");
          print("${response.data['data']['user']['token']}");
          // CacheHelper.saveName("${json["data"]['name']}");
          // CacheHelper.saveEmail("${json["data"]['email']}");
          // CacheHelper.saveRole("${json["data"]['role']}");
          isRemember ? CacheHelper.saveIfRemember() : null;
          logger.i("token: ${response.data['data']['user']['token']}");
        } else {
          emit(LoginFailedState(msg: response.data["message"]));
        }
      } on DioException catch (e) {
        handleDioException(e);
      } catch (e) {
        emit(LoginFailedState(msg: 'An unknown error: $e'));
        logger.e(e);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoadingState());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Send these tokens to your backend for verification and session management
      final response = await dioManager.post(
        ApiConstants.loginSocial,
        data: FormData.fromMap({
          'provider': 'google',
          'provider_id': result.user!.uid,
          'type': '${CacheHelper.get(key: 'deviceType')}',
          'device_token': '${CacheHelper.get(key: 'deviceToken')}',
        }),
      );
      if (response.statusCode == 200) {
        emit(SignInWithGoogleSuccessState());
        print('Successfully signed in with Google');
        // Handle successful sign-in
      } else {
        emit(SignInWithGoogleFailedState(msg: response.data["message"]));

        print('Failed to sign in with Google');
        // Handle sign-in failure
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(SignInWithGoogleFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  Future<void> signInWithApple() async {
    emit(SignInWithAppleLoadingState());
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String idToken = appleCredential.identityToken!;
      final String authorizationCode = appleCredential.authorizationCode;

      // Send these tokens to your backend for verification and session management
      final response = await dioManager.post(
        ApiConstants.loginSocial,
        data: FormData.fromMap({
          'provider': 'apple',
          'provider_id': idToken,
          'type': '${CacheHelper.get(key: 'deviceType')}',
          'device_token': '${CacheHelper.get(key: 'deviceToken')}',
        }),
      );

      if (response.statusCode == 200) {
        emit(SignInWithAppleSuccessState());

        print('Successfully signed in with Apple');
        // Handle successful sign-in
      } else {
        emit(SignInWithAppleFailedState(msg: response.data["message"]));

        print('Failed to sign in with Apple');
        // Handle sign-in failure
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      emit(SignInWithAppleFailedState(msg: 'An unknown error: $e'));
      logger.e(e);
    }
  }

  void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        emit(LoginFailedState(msg: "Request was cancelled"));
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        emit(NetworkErrorState());
        break;
      case DioExceptionType.badResponse:
        emit(LoginFailedState(msg: "${e.response?.data}"));
        break;
      default:
        emit(NetworkErrorState());
    }
    logger.e(e);
  }

  changeVisibility() {
    isObscure = !isObscure;
    emit(ChanceVisibilityState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
