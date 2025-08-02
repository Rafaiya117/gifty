// chat_service.dart
import 'dart:convert';
import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/pages/chatbot_screen.dart';


class ChatService {
  String? _sessionId;
  String? get sessionId => _sessionId;

  Future<String?> sendUserMessage({required BuildContext context, required String text, required void Function(ChatMessage) onBotMessage,}) async {
    final body = {
      'message': text,
      if (_sessionId != null) 'session_id': _sessionId,
    };

    final appState = context.read<ApplicationState>();
    final response = await appState.userState.sendMessage(body);

    final sessionIdFromResponse = response['session_id'] as String?;
    final botMessage = response['message'] as String?;

    if (sessionIdFromResponse != null) {
      _sessionId = sessionIdFromResponse;
    }

    if (botMessage != null) {
      onBotMessage(ChatMessage(text: botMessage, isUser: false));
    }

    return _sessionId;
  }

  Future<void> sendFollowUpMessage({required BuildContext context, required String message, required void Function(dynamic) onRawMessage, required void Function(List<Map<String, dynamic>>) onProducts,}) async {
    if (_sessionId == null) return;

    final appState = context.read<ApplicationState>();
    final response = await appState.userState.continueChat(
      sessionId: _sessionId!,
      message: message,
    );

    if (response.isEmpty || response['message'] == null) return;

    dynamic rawMessage = response['message'];

    if (rawMessage is String) {
      rawMessage = rawMessage.trim();
      try {
        final decoded = jsonDecode(rawMessage);
        if (decoded is List) {
          onProducts(List<Map<String, dynamic>>.from(decoded));
          return;
        }
        if (decoded is Map<String, dynamic>) {
          rawMessage = decoded['assistant'] ?? decoded['response'] ?? rawMessage;
        }
      } catch (_) {}
    }
    onRawMessage(rawMessage.toString());
    onProducts([]);
  }
}