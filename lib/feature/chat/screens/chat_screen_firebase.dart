// import 'package:flutter/material.dart';
// import 'package:projekt_481_play_with_me/feature/chat/widgets/chat_app_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: ChatAppBar(),
//       body: Column(
//         children: [
//           Expanded(child: MessagesList()), // Виджет для отображения сообщений
//           NewMessageField(), // Поле для отправки нового сообщения
//         ],
//       ),
//     );
//   }
// }

// class MessagesList extends StatelessWidget {
//   const MessagesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('messages')
//           .orderBy('createdAt', descending: true)
//           .snapshots(),
//       builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
//         if (chatSnapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final chatDocs = chatSnapshot.data!.docs;
//         return ListView.builder(
//           reverse: true,
//           itemCount: chatDocs.length,
//           itemBuilder: (ctx, index) => MessageBubble(
//             message: chatDocs[index]['text'],
//             isMe: chatDocs[index]['userId'] ==
//                 FirebaseAuth.instance.currentUser?.uid,
//           ),
//         );
//       },
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   final String message;
//   final bool isMe;

//   const MessageBubble({super.key, required this.message, required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.grey[300] : Theme.of(context).primaryColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           width: 140,
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           child: Text(
//             message,
//             style: TextStyle(color: isMe ? Colors.black : Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class NewMessageField extends StatefulWidget {
//   const NewMessageField({super.key});

//   @override
//   _NewMessageFieldState createState() => _NewMessageFieldState();
// }

// class _NewMessageFieldState extends State<NewMessageField> {
//   final _controller = TextEditingController();

//   void _sendMessage() async {
//     if (_controller.text.trim().isEmpty) return;

//     FocusScope.of(context).unfocus();

//     final user = FirebaseAuth.instance.currentUser;
//     FirebaseFirestore.instance.collection('messages').add({
//       'text': _controller.text,
//       'createdAt': Timestamp.now(),
//       'userId': user!.uid,
//     });

//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration:
//                   const InputDecoration(labelText: 'Отправить сообщение...'),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }
