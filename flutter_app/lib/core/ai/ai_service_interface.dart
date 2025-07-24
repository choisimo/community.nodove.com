abstract class AIServiceInterface {
  Future<List<String>> suggestTitles(String content);
  Future<String> improveContent(String draft);
  Future<List<String>> generateTags(String content);
  Future<String> classifyCategory(String title, String content);
  Future<String> generateSummary(String fullContent);
  Future<List<String>> generateKeywords(String content);
  Future<bool> isSpamContent(String content);
  Future<String> translateText(String text, String targetLang);
  Future<String> detectLanguage(String text);
  Future<String> answerQuestion(String question, String context);
}

class AIRequest {
  final String action;
  final Map<String, dynamic> data;
  final String? userId;

  AIRequest({
    required this.action,
    required this.data,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'data': data,
      if (userId != null) 'userId': userId,
    };
  }
}

class AIResponse {
  final bool success;
  final dynamic data;
  final String? error;
  final Map<String, dynamic>? metadata;

  AIResponse({
    required this.success,
    this.data,
    this.error,
    this.metadata,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      success: json['success'] ?? false,
      data: json['data'],
      error: json['error'],
      metadata: json['metadata'],
    );
  }
}

enum AIFeature {
  titleSuggestion,
  contentImprovement,
  tagGeneration,
  categoryClassification,
  contentSummary,
  keywordExtraction,
  spamDetection,
  translation,
  languageDetection,
  chatBot,
  recommendation,
}

enum UserTier {
  free,
  premium,
  enterprise,
}

class AILimits {
  final int dailyRequests;
  final List<AIFeature> features;
  final int maxContentLength;

  const AILimits({
    required this.dailyRequests,
    required this.features,
    this.maxContentLength = 10000,
  });
}