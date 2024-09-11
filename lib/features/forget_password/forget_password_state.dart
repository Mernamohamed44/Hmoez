abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordNetworkErrorState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {}

class ForgetPasswordFailureState extends ForgetPasswordStates {
  final String msg;

  ForgetPasswordFailureState({required this.msg});
}

class OtpLoadingState extends ForgetPasswordStates {}

class OtpSuccessState extends ForgetPasswordStates {}

class OtpFailureState extends ForgetPasswordStates {
  final String msg;

  OtpFailureState({required this.msg});
}
