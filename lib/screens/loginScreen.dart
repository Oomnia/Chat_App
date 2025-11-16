import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:chat_app/widgets/custom_login_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await signUser();
                        Navigator.pushNamed(context, 'ChatScreen', arguments: email);
                      } on FirebaseAuthException catch (e) {
                        print('Error code: ${e.code}');
                        print('Error message: ${e.message}');
                        if (e.code == 'user-not-found' ||
                            e.code == 'invalid-credential') {
                          showSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'invalid-credential') {
                          showSnackBar(context, 'Wrong password !');
                        }
                      }
                      isLoading = false;
                      setState(() {});
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
    );
  }

  Future<void> signUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
