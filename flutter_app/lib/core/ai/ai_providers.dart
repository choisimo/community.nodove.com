import 'package:flutter_chat_client/core/ai/ai_service_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_client/core/ai/openai_service.dart';

// AI 서비스 구성
final aiConfigProvider = Provider<AIConfig>((ref) {
  return AIConfig(
    openaiApiKey: const String.fromEnvironment('OPENAI_API_KEY', defaultValue: ''),
    baseUrl: const String.fromEnvironment('AI_API_BASE_URL', defaultValue: 'https://api.openai.com/v1'),
    maxRequestsPerDay: 100,
  );
});

// AI 서비스 인스턴스
final aiServiceProvider = Provider<AIServiceInterface>((ref) {
  final config = ref.read(aiConfigProvider);
  return OpenAIService(
    apiKey: config.openaiApiKey,
    baseUrl: config.baseUrl,
  );
});

// AI 사용량 추적
final aiUsageProvider = StateNotifierProvider<AIUsageNotifier, AIUsageState>((ref) {
  return AIUsageNotifier();
});

// AI 작성 도우미 상태
final aiWritingAssistantProvider = StateNotifierProvider<AIWritingAssistantNotifier, AIWritingState>((ref) {
  final aiService = ref.read(aiServiceProvider);
  final usageNotifier = ref.read(aiUsageProvider.notifier);
  return AIWritingAssistantNotifier(aiService, usageNotifier);
});

// 게시물 요약 프로바이더
final postSummaryProvider = FutureProvider.family<String, String>((ref, content) async {
  final aiService = ref.read(aiServiceProvider);
  return await aiService.generateSummary(content);
});

// AI 태그 제안 프로바이더
final aiTagSuggestionsProvider = StateNotifierProvider<AITagSuggestionsNotifier, AsyncValue<List<String>>>((ref) {
  final aiService = ref.read(aiServiceProvider);
  return AITagSuggestionsNotifier(aiService);
});

// AI 챗봇 프로바이더
final aiChatBotProvider = StateNotifierProvider<AIChatBotNotifier, AIChatBotState>((ref) {
  final aiService = ref.read(aiServiceProvider);
  return AIChatBotNotifier(aiService);
});

class AIConfig {
  final String openaiApiKey;
  final String baseUrl;
  final int maxRequestsPerDay;

  AIConfig({
    required this.openaiApiKey,
    required this.baseUrl,
    required this.maxRequestsPerDay,
  });
}

class AIUsageState {
  final int dailyRequests;
  final Map<AIFeature, int> featureUsage;
  final DateTime lastReset;
  final UserTier userTier;

  AIUsageState({
    this.dailyRequests = 0,
    this.featureUsage = const {},
    required this.lastReset,
    this.userTier = UserTier.free,
  });

  AIUsageState copyWith({
    int? dailyRequests,
    Map<AIFeature, int>? featureUsage,
    DateTime? lastReset,
    UserTier? userTier,
  }) {
    return AIUsageState(
      dailyRequests: dailyRequests ?? this.dailyRequests,
      featureUsage: featureUsage ?? this.featureUsage,
      lastReset: lastReset ?? this.lastReset,
      userTier: userTier ?? this.userTier,
    );
  }

  bool canUseFeature(AIFeature feature) {
    final limits = _getLimitsForTier(userTier);
    return limits.features.contains(feature) && dailyRequests < limits.dailyRequests;
  }

  AILimits _getLimitsForTier(UserTier tier) {
    switch (tier) {
      case UserTier.free:
        return const AILimits(
          dailyRequests: 10,
          features: [
            AIFeature.titleSuggestion,
            AIFeature.tagGeneration,
            AIFeature.contentSummary,
          ],
        );
      case UserTier.premium:
        return const AILimits(
          dailyRequests: 100,
          features: AIFeature.values,
        );
      case UserTier.enterprise:
        return const AILimits(
          dailyRequests: 1000,
          features: AIFeature.values,
        );
    }
  }
}

class AIUsageNotifier extends StateNotifier<AIUsageState> {
  AIUsageNotifier() : super(AIUsageState(lastReset: DateTime.now()));

  void incrementUsage(AIFeature feature) {
    final now = DateTime.now();
    
    // 일일 사용량 리셋 체크
    if (_shouldResetDaily(now)) {
      state = AIUsageState(lastReset: now);
    }

    final newFeatureUsage = Map<AIFeature, int>.from(state.featureUsage);
    newFeatureUsage[feature] = (newFeatureUsage[feature] ?? 0) + 1;

    state = state.copyWith(
      dailyRequests: state.dailyRequests + 1,
      featureUsage: newFeatureUsage,
    );
  }

  bool _shouldResetDaily(DateTime now) {
    return now.difference(state.lastReset).inDays >= 1;
  }

  void setUserTier(UserTier tier) {
    state = state.copyWith(userTier: tier);
  }
}

class AIWritingState {
  final List<String> suggestedTitles;
  final List<String> suggestedTags;
  final String? improvedContent;
  final String? detectedCategory;
  final bool isLoading;
  final String? error;

  AIWritingState({
    this.suggestedTitles = const [],
    this.suggestedTags = const [],
    this.improvedContent,
    this.detectedCategory,
    this.isLoading = false,
    this.error,
  });

  AIWritingState copyWith({
    List<String>? suggestedTitles,
    List<String>? suggestedTags,
    String? improvedContent,
    String? detectedCategory,
    bool? isLoading,
    String? error,
  }) {
    return AIWritingState(
      suggestedTitles: suggestedTitles ?? this.suggestedTitles,
      suggestedTags: suggestedTags ?? this.suggestedTags,
      improvedContent: improvedContent ?? this.improvedContent,
      detectedCategory: detectedCategory ?? this.detectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AIWritingAssistantNotifier extends StateNotifier<AIWritingState> {
  final AIServiceInterface _aiService;
  final AIUsageNotifier _usageNotifier;

  AIWritingAssistantNotifier(this._aiService, this._usageNotifier) : super(AIWritingState());

  Future<void> suggestTitles(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final titles = await _aiService.suggestTitles(content);
      _usageNotifier.incrementUsage(AIFeature.titleSuggestion);
      state = state.copyWith(
        suggestedTitles: titles,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: '제목 제안을 가져올 수 없습니다: $e',
        isLoading: false,
      );
    }
  }

  Future<void> generateTags(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final tags = await _aiService.generateTags(content);
      _usageNotifier.incrementUsage(AIFeature.tagGeneration);
      state = state.copyWith(
        suggestedTags: tags,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: '태그 생성을 할 수 없습니다: $e',
        isLoading: false,
      );
    }
  }

  Future<void> improveContent(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final improved = await _aiService.improveContent(content);
      _usageNotifier.incrementUsage(AIFeature.contentImprovement);
      state = state.copyWith(
        improvedContent: improved,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: '내용 개선을 할 수 없습니다: $e',
        isLoading: false,
      );
    }
  }

  Future<void> classifyCategory(String title, String content) async {
    if (title.trim().isEmpty && content.trim().isEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final category = await _aiService.classifyCategory(title, content);
      _usageNotifier.incrementUsage(AIFeature.categoryClassification);
      state = state.copyWith(
        detectedCategory: category,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: '카테고리 분류를 할 수 없습니다: $e',
        isLoading: false,
      );
    }
  }

  void clearSuggestions() {
    state = AIWritingState();
  }
}

class AITagSuggestionsNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final AIServiceInterface _aiService;

  AITagSuggestionsNotifier(this._aiService) : super(const AsyncValue.data([]));

  Future<void> generateTags(String content) async {
    if (content.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();

    try {
      final tags = await _aiService.generateTags(content);
      state = AsyncValue.data(tags);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class AIChatBotState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  AIChatBotState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  AIChatBotState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return AIChatBotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

class AIChatBotNotifier extends StateNotifier<AIChatBotState> {
  final AIServiceInterface _aiService;

  AIChatBotNotifier(this._aiService) : super(AIChatBotState());

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // 사용자 메시지 추가
    final userMessage = ChatMessage(
      content: message,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      // AI 응답 생성
      final context = 'Nodove Community 도우미입니다. 커뮤니티 사용법, 글쓰기 팁, 기능 안내 등을 도와드립니다.';
      final response = await _aiService.answerQuestion(message, context);

      final aiMessage = ChatMessage(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'AI 응답을 생성할 수 없습니다: $e',
        isLoading: false,
      );
    }
  }

  void clearChat() {
    state = AIChatBotState();
  }
}