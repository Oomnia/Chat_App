import 'package:chat_app/screens/cubits/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  Future<void> signUser({
    required String email,
    required String password,
  }) async {
    emit(LoadingState());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        emit(FailureState(errmessage:'No user found for that email.' ));
      } else if (e.code == 'invalid-credential') {
        emit(FailureState(errmessage: 'Wrong password !'));
      }
    } catch (ex) {
      emit(FailureState(errmessage: 'Something went wrong'));
    }
  }
}
