import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:pharmai/domain/entities/chat_message.dart';

class GeminiChatService {
  GeminiChatService({required String apiKey, http.Client? httpClient})
    : _model =
          apiKey.trim().isNotEmpty
              ? GenerativeModel(
                model: 'gemini-2.0-flash-exp',
                apiKey: apiKey.trim(),
                httpClient: httpClient,
              )
              : null;

  final GenerativeModel? _model;

  static const String _systemPromptBase =
      'CRITICAL DIRECTIVE: You must reply 100% in the exact language the '
      'user used to ask the question. If the input is Turkish, every single '
      'word of your output must be Turkish (using local clinical jargon). If '
      'English, reply 100% in English. Never mix languages, never include '
      'translations of your response, and never default to English if the '
      'prompt is in Turkish. You are PharmAI, a clinical assistant. Be '
      'concise, no filler or generic disclaimers. Use bullets when helpful. '
      'If key data are missing, ask one short follow-up question.';

  static const String _titlePrompt =
      'Generate a short 3-word chat title. Use title case, no punctuation. '
      'Return only the title.';

  Future<String> generateReply({
    required List<ChatMessage> history,
    required String message,
    required String localeCode,
  }) async {
    final model = _model;
    if (model == null) {
      throw Exception(
        'Gemini API key is missing. Please configure it in .env.',
      );
    }

    final contents = <Content>[
      Content('user', [TextPart(_buildSystemPrompt(localeCode))]),
      ...history.map(
        (m) => Content(m.role == ChatRole.user ? 'user' : 'model', [
          TextPart(m.content),
        ]),
      ),
      Content('user', [TextPart(message)]),
    ];

    final response = await model.generateContent(contents);
    final text = response.text?.trim();
    if (text == null || text.isEmpty) {
      throw Exception('Empty response from Gemini.');
    }
    return text;
  }

  Stream<String> streamReply({
    required List<ChatMessage> history,
    required String message,
    required String localeCode,
  }) async* {
    final model = _model;
    if (model == null) {
      throw Exception(
        'Gemini API key is missing. Please configure it in .env.',
      );
    }

    final contents = <Content>[
      Content('user', [TextPart(_buildSystemPrompt(localeCode))]),
      ...history.map(
        (m) => Content(m.role == ChatRole.user ? 'user' : 'model', [
          TextPart(m.content),
        ]),
      ),
      Content('user', [TextPart(message)]),
    ];

    final stream = model.generateContentStream(contents);
    await for (final chunk in stream) {
      final text = chunk.text;
      if (text == null || text.isEmpty) continue;
      yield text;
    }
  }

  Future<String> generateTitle({required String prompt}) async {
    final model = _model;
    if (model == null) {
      throw Exception(
        'Gemini API key is missing. Please configure it in .env.',
      );
    }

    final contents = <Content>[
      Content('user', [TextPart(_titlePrompt)]),
      Content('user', [TextPart(prompt)]),
    ];

    final response = await model.generateContent(contents);
    final text = response.text?.trim();
    if (text == null || text.isEmpty) {
      throw Exception('Empty title response from Gemini.');
    }
    return text;
  }

  static String _buildSystemPrompt(String localeCode) {
    final locale = localeCode.trim().isEmpty ? 'tr' : localeCode.trim();
    return '$_systemPromptBase\nLocale hint: $locale';
  }
}
