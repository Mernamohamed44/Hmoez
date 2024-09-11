abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterNetworkErrorState extends RegisterStates {}

class RegisterFailedState extends RegisterStates {
  final String msg;

  RegisterFailedState({required this.msg});
}

class RegisterWithGoogleLoadingState extends RegisterStates {}

class RegisterWithGoogleSuccessState extends RegisterStates {}

class RegisterWithGoogleFailedState extends RegisterStates {
  final String msg;

  RegisterWithGoogleFailedState({required this.msg});
}

class RegisterWithAppleLoadingState extends RegisterStates {}

class RegisterWithAppleSuccessState extends RegisterStates {}

class RegisterWithAppleFailedState extends RegisterStates {
  final String msg;

  RegisterWithAppleFailedState({required this.msg});
}

class UploadProfileImageStates extends RegisterStates {}

class ChanceVisibilityState extends RegisterStates {}

class ConChangeVisibilityState extends RegisterStates {}
