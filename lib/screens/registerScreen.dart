import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/cubits/register_cubit/register_states.dart';
import 'package:chat_app/widgets/custom_login_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});

  static String id = 'RegisterScreen';

  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is LoadingState) {
          isLoading = true;
        } else if (state is SuccessState) {
          showSnackBar(context, state.donemessage);
          Navigator.pushNamed(context, 'ChatScreen', arguments: email);
          isLoading = false;
        } else if (state is FailureState) {
          showSnackBar(context, state.errmessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
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
                          'Register',
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
                      hint: 'Password',
                      onChanded: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomLoginButton(
                      buttonName: 'Register',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '  Login',
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
        );
      },
    );
  }
}
