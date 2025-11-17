import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_states.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({super.key});
  List<MessageModel> messagesList = [];

  static String id = 'ChatScreen';
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logo, height: 60),
            Text(
              'Scolar Chat',
              style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatStates>(
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  messagesList = state.messagesList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) =>
                      messagesList[index].id == email
                      ? ChatBuble(message: messagesList[index])
                      : ChatBubleforOthers(message: messagesList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).sendMessage(message: data, email: email.toString());
                controller.clear();
                scrollController.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },

              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  color: primaryColor,
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(
                      context,
                    ).sendMessage(message: controller.text, email: email.toString());


                    controller.clear();
                    scrollController.animateTo(
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
