import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:manifesto/features/dashboard/domain/entities/chat_stream_event.dart';

/// Parses an SSE `text/event-stream` body into [ChatStreamEvent]s.
class SseChatParser {
  const SseChatParser();

  Stream<ChatStreamEvent> parse(ResponseBody body) async* {
    final buffer = StringBuffer();

    await for (final Uint8List chunk in body.stream) {
      buffer.write(utf8.decode(chunk, allowMalformed: true));

      while (true) {
        final raw = buffer.toString();
        final separatorIndex = _eventSeparatorIndex(raw);
        if (separatorIndex < 0) break;

        final eventBlock = raw.substring(0, separatorIndex);
        final remaining = raw.substring(separatorIndex + _separatorLength(raw, separatorIndex));
        buffer
          ..clear()
          ..write(remaining);

        final event = _parseEventBlock(eventBlock);
        if (event != null) {
          yield event;
          if (event is ChatStreamMessageEnd || event is ChatStreamError) {
            return;
          }
        }
      }
    }

    final trailing = buffer.toString().trim();
    if (trailing.isNotEmpty) {
      final event = _parseEventBlock(trailing);
      if (event != null) yield event;
    }
  }

  int _eventSeparatorIndex(String raw) {
    final lf = raw.indexOf('\n\n');
    final crlf = raw.indexOf('\r\n\r\n');
    if (lf < 0) return crlf;
    if (crlf < 0) return lf;
    return lf < crlf ? lf : crlf;
  }

  int _separatorLength(String raw, int index) {
    if (raw.startsWith('\r\n\r\n', index)) return 4;
    return 2;
  }

  ChatStreamEvent? _parseEventBlock(String block) {
    final dataLines = <String>[];
    for (final line in block.split(RegExp(r'\r?\n'))) {
      if (line.isEmpty || line.startsWith(':')) continue;
      if (line.startsWith('data:')) {
        dataLines.add(line.substring(5).trimLeft());
      }
    }
    if (dataLines.isEmpty) return null;

    final payload = dataLines.join('\n').trim();
    if (payload.isEmpty || payload == '[DONE]') {
      return const ChatStreamMessageEnd();
    }

    try {
      final json = jsonDecode(payload);
      if (json is! Map) {
        return ChatStreamError('Unexpected SSE payload: $payload');
      }
      return fromJson(Map<String, dynamic>.from(json));
    } catch (e) {
      return ChatStreamError('Failed to parse SSE payload: $e');
    }
  }

  ChatStreamEvent fromJson(Map<String, dynamic> json) {
    final type = (json['type'] as String?)?.toLowerCase() ?? '';
    switch (type) {
      case 'message_start':
        return ChatStreamMessageStart(
          chatId: json['chatId'] as String? ?? json['chat_id'] as String?,
          turnId: json['turnId'] as String? ?? json['turn_id'] as String?,
        );
      case 'token':
      case 'text':
        final text = json['text'] as String? ?? '';
        return ChatStreamToken(text);
      case 'message_end':
      case 'done':
        return ChatStreamMessageEnd(
          chatId: json['chatId'] as String? ?? json['chat_id'] as String?,
          turnId: json['turnId'] as String? ?? json['turn_id'] as String?,
        );
      case 'error':
        final message = json['message'] as String? ??
            json['detail'] as String? ??
            json['text'] as String? ??
            'Stream error';
        return ChatStreamError(message);
      case 'tool_call':
      case 'tool_result':
      case 'citation':
        return ChatStreamIgnored(type);
      default:
        // Some servers send token chunks without type; prefer text field.
        if (json.containsKey('text') && json['text'] is String) {
          return ChatStreamToken(json['text'] as String);
        }
        return ChatStreamIgnored(type.isEmpty ? 'unknown' : type);
    }
  }
}
