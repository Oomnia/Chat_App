abstract class LoginStates {}

class InitialState extends LoginStates {}

class LoadingState extends LoginStates {}

class SuccessState extends LoginStates {}

class FailureState extends LoginStates {
  String errmessage;
  FailureState({required this.errmessage});
}
