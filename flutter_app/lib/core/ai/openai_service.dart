import 'package:flutter_chat_client/core/ai/ai_service_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAIService implements AIServiceInterface {
  final String apiKey;
  final String baseUrl;
  
  OpenAIService({
    required this.apiKey,
    this.baseUrl = 'https://api.openai.com/v1',
  });

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  @override
  Future<List<String>> suggestTitles(String content) async {
    final prompt = '''
다음 게시물 내용을 바탕으로 매력적이고 적절한 제목 3개를 추천해주세요.
내용: $content

제목들은 간결하고 흥미롭게 작성해주세요.
응답 형식: ["제목1", "제목2", "제목3"]
''';

    try {
      final response = await _makeRequest(prompt);
      final titles = _parseListResponse(response);
      return titles.take(3).toList();
    } catch (e) {
      return ['제목을 입력해주세요', '새로운 게시물', '커뮤니티 글'];
    }
  }

  @override
  Future<String> improveContent(String draft) async {
    final prompt = '''
다음 게시물 초안을 더 읽기 좋고 명확하게 개선해주세요. 
원래 의미는 유지하면서 문법과 표현을 다듬어주세요.

초안: $draft

개선된 내용만 응답해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim();
    } catch (e) {
      return draft;
    }
  }

  @override
  Future<List<String>> generateTags(String content) async {
    final prompt = '''
다음 게시물 내용을 분석하여 적절한 태그 5개를 생성해주세요.

내용: $content

태그는 한글로 작성하고, 해시태그 없이 단어만 제공해주세요.
응답 형식: ["태그1", "태그2", "태그3", "태그4", "태그5"]
''';

    try {
      final response = await _makeRequest(prompt);
      final tags = _parseListResponse(response);
      return tags.take(5).toList();
    } catch (e) {
      return ['일반', '커뮤니티', '이야기'];
    }
  }

  @override
  Future<String> classifyCategory(String title, String content) async {
    final prompt = '''
다음 게시물의 제목과 내용을 분석하여 가장 적절한 카테고리를 선택해주세요.

제목: $title
내용: $content

카테고리 옵션: tech, life, food, travel, entertainment, sports, education, health
카테고리명만 응답해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim().toLowerCase();
    } catch (e) {
      return 'general';
    }
  }

  @override
  Future<String> generateSummary(String fullContent) async {
    final prompt = '''
다음 게시물을 2-3문장으로 요약해주세요. 핵심 내용을 간결하게 전달해주세요.

내용: $fullContent

요약만 응답해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim();
    } catch (e) {
      return '게시물 요약을 생성할 수 없습니다.';
    }
  }

  @override
  Future<List<String>> generateKeywords(String content) async {
    final prompt = '''
다음 내용에서 핵심 키워드 5개를 추출해주세요.

내용: $content

응답 형식: ["키워드1", "키워드2", "키워드3", "키워드4", "키워드5"]
''';

    try {
      final response = await _makeRequest(prompt);
      final keywords = _parseListResponse(response);
      return keywords.take(5).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> isSpamContent(String content) async {
    final prompt = '''
다음 내용이 스팸이나 부적절한 콘텐츠인지 판단해주세요.
스팸 기준: 광고, 도배, 욕설, 혐오 표현, 개인정보 노출 등

내용: $content

응답: true (스팸) 또는 false (정상)
true/false만 응답해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim().toLowerCase() == 'true';
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> translateText(String text, String targetLang) async {
    final prompt = '''
다음 텍스트를 $targetLang으로 번역해주세요.

텍스트: $text

번역된 텍스트만 응답해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim();
    } catch (e) {
      return text;
    }
  }

  @override
  Future<String> detectLanguage(String text) async {
    final prompt = '''
다음 텍스트의 언어를 감지해주세요.

텍스트: $text

언어 코드만 응답해주세요 (예: ko, en, ja, zh).
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim().toLowerCase();
    } catch (e) {
      return 'ko';
    }
  }

  @override
  Future<String> answerQuestion(String question, String context) async {
    final prompt = '''
사용자 질문에 대해 주어진 맥락을 바탕으로 도움이 되는 답변을 해주세요.

질문: $question
맥락: $context

친절하고 정확한 답변을 해주세요.
''';

    try {
      final response = await _makeRequest(prompt);
      return response.trim();
    } catch (e) {
      return '죄송합니다. 현재 답변을 생성할 수 없습니다.';
    }
  }

  Future<String> _makeRequest(String prompt) async {
    final body = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': prompt,
        }
      ],
      'max_tokens': 500,
      'temperature': 0.7,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/chat/completions'),
      headers: _headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('AI API 요청 실패: ${response.statusCode}');
    }
  }

  List<String> _parseListResponse(String response) {
    try {
      // JSON 배열 형태로 파싱 시도
      final decoded = json.decode(response);
      if (decoded is List) {
        return decoded.map((e) => e.toString()).toList();
      }
    } catch (e) {
      // JSON 파싱 실패 시 텍스트에서 추출
    }

    // 텍스트에서 리스트 추출
    final lines = response
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.replaceAll(RegExp(r'^[\d\-\*\.\s]+'), ''))
        .map((line) => line.replaceAll(RegExp(r'^"'), ''))
        .map((line) => line.replaceAll(RegExp(r'"$'), ''))
        .where((line) => line.trim().isNotEmpty)
        .toList();

    return lines;
  }
}