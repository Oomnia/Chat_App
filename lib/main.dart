
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/bloc/auth_bloc.dart';
import 'package:chat_app/screens/chatScreen.dart';
import 'package:chat_app/screens/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/screens/registerScreen.dart';
import 'package:chat_app/simpleblocobserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = Simpleblocobserver();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubitCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'LoginScreen': (context) => Loginscreen(),
          Registerscreen.id: (context) => Registerscreen(),
          'ChatScreen': (context) => Chatscreen(),
        },
        initialRoute: 'LoginScreen',
      ),
    );
  }
}
