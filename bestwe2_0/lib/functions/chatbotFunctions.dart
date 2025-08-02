// Future<void> sendUserMessage(String text) async {
//   final body = {
//     'message': text,
//     if (_sessionId != null) 'session_id': _sessionId,
//   };
//
//   final appState = context.read<ApplicationState>();
//   final response = await appState.userState.sendMessage(body);
//   print('Chatbot response: $response');
//
//   final sessionIdFromResponse = response['session_id'] as String?;
//   final botMessage = response['message'] as String?;
//
//   if (sessionIdFromResponse != null) {
//     _sessionId = sessionIdFromResponse;
//   }
//
//   if (botMessage != null) {
//     setState(() {
//       _messages.add(ChatMessage(text: botMessage, isUser: false));
//     });
//   }
// }
//
//
//
// Future<void> _sendFollowUpMessage(String message) async {
//   if (_sessionId == null) return;
//
//   final appState = context.read<ApplicationState>();
//
//   final response = await appState.userState.continueChat(
//     sessionId: _sessionId!,
//     message: message,
//   );
//
//   if (response.isEmpty || response['message'] == null) return;
//
//   dynamic rawMessage = response['message'];
//
//   if (rawMessage is String) {
//     rawMessage = rawMessage.trim();
//
//     // ✅ Try to decode JSON from the string
//     if ((rawMessage.startsWith('{') && rawMessage.endsWith('}')) ||
//         (rawMessage.startsWith('[') && rawMessage.endsWith(']'))) {
//       try {
//         final decoded = jsonDecode(rawMessage);
//
//         // ✅ Handle a product list (JSON array)
//         if (decoded is List) {
//           setState(() {
//             _suggestedProducts.clear();
//             _suggestedProducts.addAll(List<Map<String, dynamic>>.from(decoded));
//           });
//           return; // Stop here, don't add message to chat
//         }
//
//         // ✅ Handle assistant reply (JSON object)
//         if (decoded is Map<String, dynamic>) {
//           rawMessage = decoded['assistant'] ?? decoded['response'] ?? rawMessage;
//         }
//       } catch (e) {
//         print('❌ Failed to decode message JSON: $e');
//       }
//     }
//   }
//
//   // ✅ Fallback to plain message
//   setState(() {
//     _messages.add(ChatMessage(text: rawMessage.toString(), isUser: false));
//     _suggestedProducts.clear();
//   });
// }
//
//
// Future<void> handleMessageSend(String text) async {
//   final userMessage = text.trim();
//   if (userMessage.isEmpty) return;
//
//   _controller.clear();
//
//   setState(() {
//     _messages.add(ChatMessage(text: userMessage, isUser: true));
//     _suggestedProducts.clear();
//   });
//
//   if (_sessionId == null) {
//     await sendUserMessage(userMessage);
//   } else {
//     await _sendFollowUpMessage(userMessage);
//   }
// }