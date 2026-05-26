import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pharmai/domain/entities/chat_message.dart';

class GeminiChatService {
  GeminiChatService({required String apiKey})
    : _apiKey = apiKey.trim(),
      _model = apiKey.trim().isNotEmpty
          ? GenerativeModel(
              model: 'gemini-2.5-flash-lite',
              apiKey: apiKey.trim(),
            )
          : null;

  final String _apiKey;
  final GenerativeModel? _model;

  static const String _systemPrompt =
      'You are a senior clinician. Provide concise, evidence-aligned medical '
      'guidance for clinical decision support. Ask brief follow-up questions '
      'if key data are missing. Structure answers with: Summary, Rationale, '
      'Next steps. If uncertain, say so and suggest safe next actions.';

  static const String _titlePrompt =
      'Generate a short 3-word chat title. Use title case, no punctuation. '
      'Return only the title.';

  Future<String> generateReply({
    required List<ChatMessage> history,
    required String message,
  }) async {
    if (_model == null) {
      throw Exception('Gemini API key is missing. Please configure it in .env.');
    }

    final contents = <Content>[
      Content('user', [TextPart(_systemPrompt)]),
      ...history.map(
        (m) => Content(m.role == ChatRole.user ? 'user' : 'model', [
          TextPart(m.content),
        ]),
      ),
      Content('user', [TextPart(message)]),
    ];

    final response = await _model!.generateContent(contents);
    final text = response.text?.trim();
    if (text == null || text.isEmpty) {
      throw Exception('Empty response from Gemini.');
    }
    return text;
  }

  Future<String> generateTitle({required String prompt}) async {
    if (_model == null) {
      throw Exception('Gemini API key is missing. Please configure it in .env.');
    }

    final contents = <Content>[
      Content('user', [TextPart(_titlePrompt)]),
      Content('user', [TextPart(prompt)]),
    ];

    final response = await _model!.generateContent(contents);
    final text = response.text?.trim();
    if (text == null || text.isEmpty) {
      throw Exception('Empty title response from Gemini.');
    }
    return text;
  }
}
