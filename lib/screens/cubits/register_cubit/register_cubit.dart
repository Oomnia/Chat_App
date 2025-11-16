import 'package:chat_app/screens/cubits/register_cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(LoadingState());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SuccessState(donemessage: 'Created Successfully'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(
          FailureState(
            errmessage: 'The account already exists for that email.',
          ),
        );
      } else if (e.code == 'weak-password') {
        emit(FailureState(errmessage: 'weak-password.'));
      }
    } catch (ex) {
      emit(FailureState(errmessage: 'Something went wrong'));
    }
  }
}
