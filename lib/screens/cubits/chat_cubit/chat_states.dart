import 'package:chat_app/models/message_model.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatSuccessState extends ChatStates {
  List<MessageModel> messagesList;
  ChatSuccessState({required this.messagesList});
}
