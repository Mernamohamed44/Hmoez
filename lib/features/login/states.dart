abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class SignInWithGoogleLoadingState extends LoginStates {}

class SignInWithGoogleSuccessState extends LoginStates {}

class NetworkErrorState extends LoginStates {}

class LoginFailedState extends LoginStates {
  final String msg;

  LoginFailedState({required this.msg});
}

class SignInWithGoogleFailedState extends LoginStates {
  final String msg;

  SignInWithGoogleFailedState({required this.msg});
}

class SignInWithAppleFailedState extends LoginStates {
  final String msg;

  SignInWithAppleFailedState({required this.msg});
}

class SignInWithAppleLoadingState extends LoginStates {}

class SignInWithAppleSuccessState extends LoginStates {}

class ChanceVisibilityState extends LoginStates {}
