abstract class RegisterStates {}

class InitialState extends RegisterStates {}

class LoadingState extends RegisterStates {}

class SuccessState extends RegisterStates {
  String donemessage;
  SuccessState({required this.donemessage});
}

class FailureState extends RegisterStates {
  String errmessage;
  FailureState({required this.errmessage});
}
