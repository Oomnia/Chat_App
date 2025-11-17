import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    collectionName,
  );
  void sendMessage({required String message, required String email}) async {
    messages.add({
      'Message': message,
      'CreatedAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages.orderBy(kcreatedAt, descending: true).snapshots().listen((event) {
      List<MessageModel> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromjson(doc));
        emit(ChatSuccessState(messagesList: messagesList));
      }
    });
  }
}
