import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/cubits/login_cubit/login_states.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:chat_app/widgets/custom_login_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginscreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoadingState) {
          isLoading = true;
        } else if (state is SuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, 'ChatScreen', arguments: email);
          isLoading = false;
        } else if (state is FailureState) {
          showSnackBar(context, state.errmessage);

          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Color(0xff2B475E),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Image.asset('assets/images/scholar.png', height: 125),
                  Center(
                    child: Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ),
                  SizedBox(height: 100),

                  Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hint: 'Email',
                    onChanded: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    obsecureText: true,
                    hint: 'Password',
                    onChanded: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomLoginButton(
                    buttonName: 'Login',
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).signUser(email: email!, password: password!);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Registerscreen.id);
                        },
                        child: Text(
                          '  Register',
                          style: TextStyle(color: Color(0xFFC7EDE6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
