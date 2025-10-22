import 'dart:convert';

import 'package:cine_bot/models/message.dart';
import 'package:http/http.dart' as http;

class PipedreamService {
  final String _baseUrl = 'https://eonr674pj1etpo9.m.pipedream.net';

  storeMessage(Message message) async {
    final payload = {
      'timestamp': DateTime.now().toIso8601String(),
      'source': message.isUser ? 'user' : 'bot',
      'message': message.text,
    };

    final resp = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('RequestBin envio: status=${resp.statusCode}');
  }
}
