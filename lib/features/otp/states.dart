abstract class OtpStates {}

class OtpInitialState extends OtpStates {}

class OtpLoadingState extends OtpStates {}

class OtpSuccessState extends OtpStates {}

class OtpFailureState extends OtpStates {
  final String msg;

  OtpFailureState({required this.msg});
}

class NewPasswordVisibilityState extends OtpStates {}

class NewConfPasswordVisibilityState extends OtpStates {}

class NetworkErrorState extends OtpStates {}

class ReSendCodeLoadingState extends OtpStates {}

class ReSendCodeFailedState extends OtpStates {
  final String msg;

  ReSendCodeFailedState({required this.msg});
}

class ReSendCodeSuccessState extends OtpStates {
  final String msg;

  ReSendCodeSuccessState({required this.msg});
}
