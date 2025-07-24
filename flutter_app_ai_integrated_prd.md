# Nodove Community Flutter App with AI Integration - Updated PRD

## 1. 프로젝트 개요

### 1.1 프로젝트 명
- **앱 이름**: Flutter Chat Client (community.nodove.com) with AI Agent
- **플랫폼**: Flutter (iOS, Android, Web)
- **프로젝트 타입**: AI 기반 커뮤니티 포럼 애플리케이션

### 1.2 목적
AI Agent가 통합된 차세대 커뮤니티 플랫폼으로, 사용자들에게 개인화된 콘텐츠 추천, 지능형 작성 도우미, 자동 요약, 스마트 검색 등의 기능을 제공합니다.

## 2. AI 통합 기술 스택

### 2.1 기존 Flutter 의존성
```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  flutter_secure_storage: ^4.2.1
  go_router: ^14.6.3
  http: ^1.3.0
  retrofit: ^4.4.2
  riverpod_annotation: ^2.6.1
  shared_preferences: ^2.3.5
  universal_html: ^2.2.4
```

### 2.2 새로 추가된 AI 관련 구조
```
lib/
├── core/
│   └── ai/
│       ├── ai_service_interface.dart     # AI 서비스 인터페이스
│       ├── openai_service.dart          # OpenAI API 구현
│       └── ai_providers.dart            # AI 관련 Riverpod 프로바이더들
├── features/
│   ├── ai/
│   │   ├── data/
│   │   │   └── ai_recommendation_service.dart  # AI 추천 시스템
│   │   └── presentation/
│   │       └── ai_widgets.dart          # AI 관련 UI 위젯들
│   └── posts/
│       └── presentation/
│           └── post_editor_page.dart    # AI 통합 게시물 작성 페이지
```

## 3. AI 기능 상세 명세

### 3.1 AI 작성 도우미 (AI Writing Assistant)

#### 3.1.1 제목 제안 기능
- **위치**: 게시물 작성 페이지
- **트리거**: 내용 입력 후 전구 아이콘 클릭
- **기능**: 게시물 내용을 분석하여 적절한 제목 3개 제안
- **UI**: 제안된 제목들을 ActionChip으로 표시, 클릭 시 제목 입력란에 자동 입력

#### 3.1.2 태그 자동 생성
- **위치**: 게시물 작성 페이지
- **트리거**: 내용 입력 시 실시간 분석 (50자 이상)
- **기능**: 내용을 분석하여 관련 태그 5개 자동 생성
- **UI**: FilterChip으로 표시, 선택/해제 가능

#### 3.1.3 카테고리 자동 분류
- **위치**: 게시물 작성 페이지
- **트리거**: 제목과 내용 입력 시 자동 분석
- **기능**: 게시물 내용을 8개 카테고리 중 하나로 자동 분류
- **UI**: 드롭다운 옆에 AI 추천 배지 표시

#### 3.1.4 내용 개선 제안
- **위치**: 게시물 작성 페이지
- **트리거**: 플로팅 버튼 또는 AI 도우미 다이얼로그
- **기능**: 문법과 표현을 개선한 내용 제안
- **UI**: 모달 다이얼로그로 원본/개선안 비교 표시

### 3.2 AI 챗봇 도우미

#### 3.2.1 커뮤니티 도우미 기능
- **위치**: 전역에서 접근 가능 (앱바, 플로팅 버튼)
- **기능**:
  - 커뮤니티 사용법 안내
  - 글쓰기 팁 제공
  - 기능 설명
  - 일반적인 질문 답변

#### 3.2.2 챗봇 UI
- **표시 방식**: 모달 바텀시트 (DraggableScrollableSheet)
- **채팅 인터페이스**: 말풍선 형태의 대화 UI
- **기능**:
  - 실시간 대화
  - 대화 내역 저장
  - 대화 내역 초기화
  - 로딩 상태 표시

### 3.3 게시물 자동 요약

#### 3.3.1 AI 요약 위젯
- **위치**: 게시물 카드 내부
- **트리거**: 게시물 내용 길이 100자 초과 시 자동 생성
- **기능**: 2-3문장으로 게시물 핵심 내용 요약
- **UI**: 파란색 배경의 별도 섹션으로 표시, AI 아이콘 포함

### 3.4 AI 기반 개인화 추천 시스템

#### 3.4.1 맞춤형 게시물 추천
- **위치**: 메인 페이지 상단 섹션
- **기능**:
  - 사용자 행동 패턴 분석
  - 관심 카테고리/태그 기반 추천
  - 추천 점수 및 이유 표시
- **UI**: 가로 스크롤 카드 리스트, AI 추천 배지

#### 3.4.2 사용자 행동 추적
- **추적 데이터**:
  - 게시물 조회 (viewedPosts)
  - 좋아요 (likedPosts)
  - 카테고리별 상호작용 (categoryInteractions)
  - 태그별 상호작용 (tagInteractions)

#### 3.4.3 스마트 피드
- **기능**: 사용자 관심사와 트렌딩 토픽을 결합한 맞춤형 피드
- **구성**: 개인화 추천 + 트렌딩 콘텐츠

### 3.5 스마트 검색 시스템

#### 3.5.1 자연어 검색
- **위치**: 메인 페이지 검색창
- **기능**: 자연어 질문을 이해하여 관련 콘텐츠 검색
- **예시**: "Flutter 성능 최적화 방법은?" → 관련 게시물 검색

#### 3.5.2 검색 제안
- **기능**: 검색창 포커스 시 AI 기반 검색 예시 제공
- **UI**: 보라색 테마의 제안 칩들

### 3.6 AI 사용량 관리

#### 3.6.1 사용자 등급별 제한
```dart
enum UserTier {
  free: 일일 10회, 기본 기능만
  premium: 일일 100회, 전체 기능
  enterprise: 일일 1000회, 전체 기능
}
```

#### 3.6.2 사용량 표시
- **위치**: 게시물 작성 페이지 상단
- **내용**: "AI 기능 사용: X/10 (무료)"

## 4. 업데이트된 UI/UX 명세

### 4.1 메인 페이지 개선사항
- **AI 스마트 검색창**: 기존 검색창을 AI 기능이 통합된 스마트 검색으로 대체
- **AI 맞춤 추천 섹션**: 새로운 최상단 섹션 추가
- **AI 요약 적용**: 모든 게시물 카드에 AI 요약 기능 적용
- **AI 챗봇 버튼**: 앱바에 AI 도우미 접근 버튼 추가

### 4.2 게시물 작성 페이지
- **AI 도우미 통합**: 제목 제안, 태그 생성, 내용 개선 기능
- **실시간 AI 분석**: 입력 내용에 따른 실시간 카테고리/태그 제안
- **플로팅 AI 버튼**: 챗봇과 내용 개선 기능 접근
- **AI 사용량 표시**: 상단에 사용량 정보 바

### 4.3 AI 전용 UI 컴포넌트
- **AIPostSummaryWidget**: 게시물 AI 요약 표시
- **AIPostCard**: AI 추천 배지가 포함된 게시물 카드
- **SmartSearchWidget**: AI 검색 제안 기능이 포함된 검색창
- **AIChatBotBottomSheet**: 드래그 가능한 챗봇 인터페이스

## 5. 백엔드 API 요구사항 (AI 기능 추가)

### 5.1 AI 서비스 API

#### 5.1.1 AI 작성 도우미 API
```
POST /api/ai/writing-assist
Content-Type: application/json
Authorization: Bearer <token>

Request Body:
{
  "action": "suggest_titles|improve_content|generate_tags|classify_category",
  "data": {
    "content": "게시물 내용",
    "title": "게시물 제목" // classify_category 시 필요
  },
  "userId": "user_id"
}

Response:
{
  "success": true,
  "data": {
    "suggestions": ["제안1", "제안2", "제안3"], // suggest_titles, generate_tags
    "improved_content": "개선된 내용", // improve_content
    "category": "tech" // classify_category
  },
  "metadata": {
    "processingTime": 1.2,
    "model": "gpt-3.5-turbo",
    "confidence": 0.85
  }
}
```

#### 5.1.2 AI 요약 API
```
POST /api/ai/summarize
Content-Type: application/json
Authorization: Bearer <token>

Request Body:
{
  "content": "긴 게시물 내용",
  "maxLength": 200
}

Response:
{
  "success": true,
  "data": {
    "summary": "2-3문장으로 요약된 내용",
    "keywords": ["키워드1", "키워드2"]
  }
}
```

#### 5.1.3 AI 챗봇 API
```
POST /api/ai/chat
Content-Type: application/json
Authorization: Bearer <token>

Request Body:
{
  "message": "사용자 질문",
  "context": "커뮤니티 도우미",
  "conversationId": "conversation_uuid"
}

Response:
{
  "success": true,
  "data": {
    "response": "AI 답변",
    "conversationId": "conversation_uuid"
  }
}
```

### 5.2 AI 추천 시스템 API

#### 5.2.1 개인화 추천 API
```
GET /api/ai/recommendations/personalized?userId=user_id&limit=10
Authorization: Bearer <token>

Response:
{
  "success": true,
  "data": {
    "posts": [
      {
        "id": 1,
        "title": "게시물 제목",
        "excerpt": "요약",
        "recommendationScore": 0.95,
        "recommendationReason": "최근 Flutter 관련 글을 자주 읽으셨네요",
        "author": {"userNick": "작성자"},
        "category": "tech",
        "tags": ["flutter", "dart"]
      }
    ]
  }
}
```

#### 5.2.2 사용자 행동 기록 API
```
POST /api/ai/interactions
Content-Type: application/json
Authorization: Bearer <token>

Request Body:
{
  "userId": "user_id",
  "action": "view|like|comment|share",
  "postId": 123,
  "category": "tech",
  "tags": ["flutter", "performance"],
  "timestamp": "2024-01-01T00:00:00Z"
}

Response:
{
  "success": true,
  "message": "Interaction recorded"
}
```

#### 5.2.3 트렌딩 토픽 API
```
GET /api/ai/trending-topics?limit=5
Authorization: Bearer <token>

Response:
{
  "success": true,
  "data": {
    "topics": [
      {
        "topic": "Flutter 3.16",
        "count": 25,
        "growth": 0.35,
        "description": "Flutter 최신 버전 업데이트"
      }
    ]
  }
}
```

### 5.3 AI 스마트 검색 API

#### 5.3.1 자연어 검색 API
```
GET /api/ai/search?query=자연어쿼리&page=1&limit=10
Authorization: Bearer <token>

Response:
{
  "success": true,
  "data": {
    "results": [
      {
        "id": 1,
        "title": "검색 결과 제목",
        "excerpt": "내용 요약",
        "relevanceScore": 0.95,
        "searchIntent": "how_to", // how_to, what_is, comparison 등
        "matchedKeywords": ["Flutter", "성능", "최적화"]
      }
    ],
    "pagination": {...},
    "searchAnalysis": {
      "originalQuery": "Flutter 성능 최적화 방법은?",
      "processedQuery": "Flutter performance optimization methods",
      "intent": "how_to"
    }
  }
}
```

## 6. AI 시스템 아키텍처

### 6.1 클라이언트 사이드 AI 구조
```
AIServiceInterface (추상 클래스)
├── OpenAIService (OpenAI API 구현)
├── ClaudeService (Anthropic Claude API)
└── GeminiService (Google Gemini API)

AI Providers (Riverpod)
├── aiServiceProvider
├── aiWritingAssistantProvider
├── aiChatBotProvider
├── aiRecommendationServiceProvider
└── userInteractionNotifierProvider
```

### 6.2 AI 기능별 상태 관리
- **AIWritingState**: 작성 도우미 상태 (제목 제안, 태그, 카테고리)
- **AIChatBotState**: 챗봇 대화 상태 및 메시지 히스토리
- **UserInteractionState**: 사용자 행동 추적 데이터
- **AIUsageState**: AI 기능 사용량 관리

## 7. 성능 및 비용 최적화

### 7.1 AI API 호출 최적화
- **요청 배치 처리**: 여러 AI 분석을 동시에 수행
- **캐싱 전략**: 동일한 내용에 대한 AI 분석 결과 캐싱
- **사용자 등급별 제한**: 무료/유료 사용자 구분

### 7.2 UI 성능 최적화
- **지연 로딩**: AI 위젯들의 필요 시점 로딩
- **상태 최적화**: 불필요한 AI API 호출 방지
- **로딩 상태**: 사용자 경험을 위한 적절한 로딩 표시

## 8. 보안 및 프라이버시

### 8.1 AI 서비스 보안
- **API 키 관리**: 환경 변수를 통한 안전한 API 키 관리
- **사용자 데이터 보호**: 개인 정보를 포함한 AI 분석 요청 시 데이터 마스킹
- **사용량 모니터링**: AI API 남용 방지를 위한 사용량 추적

### 8.2 사용자 프라이버시
- **데이터 최소화**: AI 분석에 필요한 최소한의 데이터만 전송
- **로컬 처리**: 가능한 경우 온디바이스 AI 처리 활용
- **데이터 보존**: AI 분석 결과의 적절한 보존 기간 설정

## 9. 테스트 전략

### 9.1 AI 기능 테스트
- **Mock AI 서비스**: 테스트를 위한 Mock AI 응답 구현
- **AI 응답 검증**: AI 서비스 응답의 형식 및 내용 검증
- **에러 처리 테스트**: AI API 실패 상황에 대한 처리 테스트

### 9.2 사용자 경험 테스트
- **AI 기능 통합 테스트**: 전체 AI 워크플로우 테스트
- **성능 테스트**: AI 기능 사용 시 앱 성능 영향 측정
- **A/B 테스트**: AI 추천 정확도 및 사용자 만족도 측정

## 10. 향후 AI 기능 확장 계획

### 10.1 Phase 2 - 고급 AI 기능 (3-6개월)
- **이미지 분석**: 게시물 이미지 자동 태그 생성
- **감정 분석**: 댓글/게시물의 감정 분석 및 모더레이션
- **실시간 번역**: 다국어 지원을 위한 자동 번역
- **음성 인식**: 음성으로 게시물 작성

### 10.2 Phase 3 - AI 커뮤니티 강화 (6-12개월)
- **AI 모더레이터**: 자동 스팸/욕설 감지 및 차단
- **컨텐츠 품질 평가**: AI 기반 게시물 품질 점수
- **개인화 UI**: 사용자별 맞춤 인터페이스
- **예측 분석**: 트렌드 예측 및 인사이트 제공

## 11. 성공 지표 (KPI)

### 11.1 AI 활용 지표
- **AI 기능 사용률**: 전체 사용자 중 AI 기능 사용 비율
- **AI 제안 채택률**: AI가 제안한 내용의 사용자 채택 비율
- **사용자 만족도**: AI 기능에 대한 사용자 피드백 점수

### 11.2 비즈니스 영향 지표
- **사용자 참여도**: AI 추천으로 인한 글 읽기/작성 증가율
- **세션 시간**: AI 기능 도입 후 평균 세션 시간 변화
- **콘텐츠 품질**: AI 도우미 사용 게시물의 평균 조회수/좋아요

## 12. 결론

Nodove Community Flutter 앱에 AI Agent를 성공적으로 통합하여 다음과 같은 혁신적 기능들을 구현했습니다:

### 12.1 구현된 AI 기능
1. **AI 작성 도우미**: 제목 제안, 태그 생성, 카테고리 분류, 내용 개선
2. **AI 챗봇**: 커뮤니티 도우미 및 실시간 질의응답
3. **게시물 자동 요약**: 긴 콘텐츠의 핵심 내용 요약
4. **개인화 추천 시스템**: 사용자 행동 기반 맞춤형 콘텐츠 추천
5. **스마트 검색**: 자연어 기반 지능형 검색

### 12.2 기술적 성과
- **확장 가능한 AI 아키텍처**: 다양한 AI 서비스 연동 가능
- **효율적인 상태 관리**: Riverpod 기반 AI 상태 관리
- **사용자 친화적 UI**: AI 기능이 자연스럽게 통합된 인터페이스
- **성능 최적화**: AI API 호출 최적화 및 캐싱 전략

### 12.3 백엔드 개발 가이드라인
백엔드 개발팀은 이 명세서를 참고하여:
1. AI 서비스 API 엔드포인트 구현
2. 사용자 행동 데이터 수집 및 분석 시스템 구축
3. AI 추천 엔진 개발
4. AI API 사용량 관리 시스템 구현

이러한 AI 통합을 통해 Nodove Community는 차별화된 사용자 경험을 제공하고, 커뮤니티 참여도와 콘텐츠 품질을 크게 향상시킬 수 있을 것입니다.