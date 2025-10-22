import 'dart:convert';

class GeminiError {
  final int code;
  final String message;
  final String status;

  GeminiError({
    required this.code,
    required this.message,
    required this.status,
  });

  factory GeminiError.fromJson(Map<String, dynamic> json) {
    final error = json['error'] ?? {};
    return GeminiError(
      code: error['code'] ?? 0,
      message: error['message'] ?? 'Unknown error',
      status: error['status'] ?? 'UNKNOWN',
    );
  }

  static GeminiError? fromString(String raw) {
    final regex = RegExp(r'\{[\s\S]*\}');
    final match = regex.firstMatch(raw);
    if (match == null) return null;

    try {
      final jsonStr = match.group(0)!;
      final Map<String, dynamic> decoded = jsonDecode(jsonStr);
      return GeminiError.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }
}