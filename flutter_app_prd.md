# Nodove Community Flutter App - Product Requirements Document (PRD)

## 1. 프로젝트 개요

### 1.1 프로젝트 명
- **앱 이름**: Flutter Chat Client (community.nodove.com)
- **플랫폼**: Flutter (iOS, Android, Web)
- **프로젝트 타입**: 커뮤니티 포럼 애플리케이션

### 1.2 목적
사용자들이 게시물을 작성하고 읽을 수 있는 커뮤니티 플랫폼으로, 카테고리별 콘텐츠 관리와 사용자 인증 시스템을 제공합니다.

## 2. 기술 스택

### 2.1 Flutter 의존성
```yaml
dependencies:
  - flutter_riverpod: ^2.6.1 (상태 관리)
  - flutter_secure_storage: ^4.2.1 (보안 저장소)
  - go_router: ^14.6.3 (라우팅)
  - http: ^1.3.0 (HTTP 통신)
  - retrofit: ^4.4.2 (API 클라이언트)
  - riverpod_annotation: ^2.6.1 (코드 생성)
  - shared_preferences: ^2.3.5 (로컬 저장소)
  - universal_html: ^2.2.4 (웹 호환성)
```

## 3. 앱 구조 및 아키텍처

### 3.1 폴더 구조
```
lib/
├── app/
│   ├── app_providers.dart
│   ├── app_theme.dart
│   └── go_router.dart
├── core/
│   └── network/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       └── presentation/
├── shared/
│   └── presentation/
└── main.dart
```

### 3.2 아키텍처 패턴
- **Clean Architecture** 기반
- **Riverpod**을 활용한 상태 관리
- **GoRouter**를 활용한 선언적 라우팅

## 4. 기능 명세서

### 4.1 인증 시스템 (Authentication)

#### 4.1.1 로그인 기능
**화면**: `/user/login`
- **UI 컴포넌트**:
  - 이메일 입력 필드
  - 비밀번호 입력 필드 (마스킹 처리)
  - 로그인 버튼
  - 로딩 인디케이터
  - 에러 메시지 표시 영역

- **기능 요구사항**:
  - 이메일/비밀번호 입력 검증
  - 로그인 성공 시 메인 페이지로 리다이렉트
  - 로그인 실패 시 에러 메시지 표시
  - 인증 토큰 보안 저장 (Flutter Secure Storage)

#### 4.1.2 회원가입 기능
**화면**: `/user/join`
- **현재 상태**: 기본 UI만 구현됨
- **필요한 구현**:
  - 사용자 정보 입력 폼
  - 유효성 검증
  - 회원가입 처리 로직

#### 4.1.3 프로필 페이지
**화면**: `/user/profile`
- **현재 상태**: 기본 UI만 구현됨
- **필요한 구현**:
  - 사용자 정보 표시
  - 프로필 수정 기능
  - 로그아웃 기능

#### 4.1.4 인증 상태 관리
- **AuthStatus 클래스**를 통한 인증 상태 관리
- 토큰 기반 인증 (JWT)
- 자동 로그인 (토큰 유효성 검증)
- 로그인이 필요한 페이지 접근 시 자동 리다이렉트

### 4.2 메인 화면 (Home)

#### 4.2.1 메인 페이지
**화면**: `/` (IndexPage)

- **UI 구성**:
  - 앱바 (제목: "메인 페이지")
  - 검색창
  - 추천 게시물 섹션 (가로 스크롤)
  - 인기 카테고리 섹션 (가로 스크롤)
  - 최신 글 섹션 (세로 리스트)

- **기능 요구사항**:
  - 검색어 입력 및 검색 페이지 이동 (`/search?query=검색어`)
  - 게시물 카드 터치 시 상세 페이지 이동
  - 카테고리 선택 기능
  - 실시간 데이터 로딩

#### 4.2.2 컴포넌트 상세

**HorizontalPostList**
- 가로 스크롤 게시물 리스트
- 게시물 미리보기 카드
- 게시물 ID와 제목 표시

**HorizontalCategoryList**
- 가로 스크롤 카테고리 리스트
- 카테고리별 필터 기능

**VerticalPostList**
- 세로 스크롤 게시물 리스트
- 페이지네이션 지원 필요

**SectionTitle**
- 섹션 제목 컴포넌트
- 일관된 디자인 적용

### 4.3 게시물 시스템 (Posts)

#### 4.3.1 게시물 상세 페이지
**화면**: `/post/:id`
- **기능**:
  - 게시물 내용 표시
  - 작성자 정보
  - 작성일시
  - 좋아요/댓글 기능 (향후 구현)

#### 4.3.2 게시물 모델
```dart
class Post {
  final int id;
  final String title;
  final String content;
  // 추가 필드들 (작성자, 생성일, 수정일 등)
}
```

### 4.4 라우팅 시스템

#### 4.4.1 라우트 정의
- `/` - 메인 페이지 (IndexPage)
- `/post/:id` - 게시물 상세 페이지
- `/user/login` - 로그인 페이지
- `/user/join` - 회원가입 페이지
- `/user/profile` - 프로필 페이지
- `/search` - 검색 페이지 (미구현)

#### 4.4.2 보안 및 접근 제어
- 로그인이 필요한 페이지 접근 시 자동 로그인 페이지 리다이렉트
- 잘못된 게시물 ID 접근 시 에러 페이지 표시

### 4.5 에러 처리

#### 4.5.1 에러 페이지
- 404 페이지 없음 에러
- 잘못된 게시물 ID 에러
- 네트워크 에러 처리

## 5. 사용자 인터페이스 (UI/UX) 요구사항

### 5.1 디자인 테마
- Material Design 3 기반
- 기본 색상: 흰색 배경, 검은색 텍스트
- 앱바 elevation: 3

### 5.2 반응형 디자인
- 모바일 우선 설계
- 태블릿 및 웹 호환성

### 5.3 접근성
- 스크린 리더 지원
- 적절한 색상 대비
- 터치 타겟 크기 준수

## 6. 백엔드 API 요구사항

### 6.1 인증 API

#### 6.1.1 로그인 API
```
POST /api/auth/login
Content-Type: application/json

Request Body:
{
  "email": "user@example.com",
  "password": "password123"
}

Response (Success):
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_id",
    "userId": "user123",
    "username": "사용자명",
    "email": "user@example.com",
    "userNick": "닉네임",
    "userRole": "USER",
    "isActive": true,
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-01T00:00:00Z"
  }
}

Response (Error):
{
  "error": "Invalid credentials",
  "message": "이메일 또는 비밀번호가 올바르지 않습니다."
}
```

#### 6.1.2 회원가입 API
```
POST /api/auth/register
Content-Type: application/json

Request Body:
{
  "email": "user@example.com",
  "password": "password123",
  "userNick": "닉네임",
  "username": "사용자명" // optional
}

Response (Success):
{
  "message": "회원가입이 완료되었습니다.",
  "user": {
    "id": "user_id",
    "email": "user@example.com",
    "userNick": "닉네임"
  }
}
```

#### 6.1.3 토큰 검증 API
```
GET /api/auth/verify
Authorization: Bearer <token>

Response (Success):
{
  "valid": true,
  "user": { /* 사용자 정보 */ }
}

Response (Error):
{
  "valid": false,
  "message": "토큰이 유효하지 않습니다."
}
```

#### 6.1.4 프로필 조회 API
```
GET /api/user/profile
Authorization: Bearer <token>

Response:
{
  "id": "user_id",
  "userId": "user123",
  "username": "사용자명",
  "email": "user@example.com",
  "userNick": "닉네임",
  "userRole": "USER",
  "isActive": true,
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z"
}
```

### 6.2 게시물 API

#### 6.2.1 게시물 목록 조회 API
```
GET /api/posts?page=1&limit=10&category=tech&sort=latest
Authorization: Bearer <token>

Response:
{
  "posts": [
    {
      "id": 1,
      "title": "게시물 제목",
      "content": "게시물 내용",
      "author": {
        "id": "author_id",
        "userNick": "작성자 닉네임"
      },
      "category": "tech",
      "createdAt": "2024-01-01T00:00:00Z",
      "updatedAt": "2024-01-01T00:00:00Z",
      "viewCount": 100,
      "likeCount": 10
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 50,
    "totalPages": 5
  }
}
```

#### 6.2.2 게시물 상세 조회 API
```
GET /api/posts/:id
Authorization: Bearer <token>

Response:
{
  "id": 1,
  "title": "게시물 제목",
  "content": "게시물 상세 내용",
  "author": {
    "id": "author_id",
    "userNick": "작성자 닉네임",
    "userRole": "USER"
  },
  "category": "tech",
  "tags": ["flutter", "dart"],
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-01T00:00:00Z",
  "viewCount": 101,
  "likeCount": 10,
  "isLiked": false
}
```

#### 6.2.3 추천 게시물 API
```
GET /api/posts/recommended?limit=5
Authorization: Bearer <token>

Response:
{
  "posts": [
    {
      "id": 1,
      "title": "추천 게시물 제목",
      "excerpt": "게시물 요약...",
      "author": {
        "userNick": "작성자"
      },
      "likeCount": 25,
      "viewCount": 200
    }
  ]
}
```

#### 6.2.4 최신 게시물 API
```
GET /api/posts/latest?limit=10
Authorization: Bearer <token>

Response:
{
  "posts": [
    {
      "id": 1,
      "title": "최신 게시물",
      "excerpt": "게시물 요약...",
      "author": {
        "userNick": "작성자"
      },
      "createdAt": "2024-01-01T00:00:00Z"
    }
  ]
}
```

### 6.3 카테고리 API

#### 6.3.1 카테고리 목록 API
```
GET /api/categories
Authorization: Bearer <token>

Response:
{
  "categories": [
    {
      "id": "tech",
      "name": "기술",
      "description": "기술 관련 게시물",
      "postCount": 150,
      "isActive": true
    },
    {
      "id": "life",
      "name": "라이프",
      "description": "일상 및 라이프스타일",
      "postCount": 89,
      "isActive": true
    }
  ]
}
```

#### 6.3.2 인기 카테고리 API
```
GET /api/categories/popular?limit=5
Authorization: Bearer <token>

Response:
{
  "categories": [
    {
      "id": "tech",
      "name": "기술",
      "postCount": 150,
      "recentActivity": "2024-01-01T00:00:00Z"
    }
  ]
}
```

### 6.4 검색 API

#### 6.4.1 게시물 검색 API
```
GET /api/search?query=검색어&page=1&limit=10&category=tech
Authorization: Bearer <token>

Response:
{
  "results": [
    {
      "id": 1,
      "title": "검색 결과 제목",
      "excerpt": "검색어가 포함된 내용 요약...",
      "author": {
        "userNick": "작성자"
      },
      "category": "tech",
      "createdAt": "2024-01-01T00:00:00Z",
      "relevanceScore": 0.95
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 25,
    "totalPages": 3
  },
  "searchQuery": "검색어"
}
```

## 7. 데이터 모델

### 7.1 사용자 모델 (User)
```dart
class User {
  final String id;
  final String userId;
  final String? username;
  final String email;
  final String userNick;
  final UserRole userRole; // USER, ADMIN, MODERATOR
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
}

enum UserRole {
  USER,
  ADMIN,
  MODERATOR
}
```

### 7.2 게시물 모델 (Post)
```dart
class Post {
  final int id;
  final String title;
  final String content;
  final String excerpt; // 요약
  final User author;
  final String category;
  final List<String> tags;
  final int viewCount;
  final int likeCount;
  final bool isLiked; // 현재 사용자의 좋아요 여부
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
}
```

### 7.3 카테고리 모델 (Category)
```dart
class Category {
  final String id;
  final String name;
  final String description;
  final int postCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

## 8. 보안 요구사항

### 8.1 인증 및 권한
- JWT 토큰 기반 인증
- 토큰 만료 시간: 24시간
- Refresh Token 구현 권장
- HTTPS 통신 필수

### 8.2 데이터 보안
- 비밀번호 해싱 (bcrypt 권장)
- 사용자 입력 데이터 검증 및 살균
- SQL Injection 방지
- XSS 공격 방지

### 8.3 클라이언트 보안
- Flutter Secure Storage를 통한 토큰 저장
- 앱 백그라운드 시 민감 정보 숨김
- 디바이스 루팅/탈옥 감지 (선택사항)

## 9. 성능 요구사항

### 9.1 응답 시간
- API 응답 시간: 평균 500ms 이하
- 앱 시작 시간: 3초 이하
- 페이지 전환: 부드러운 애니메이션 (60fps)

### 9.2 네트워크 최적화
- 이미지 지연 로딩
- 페이지네이션 구현
- 캐싱 전략 수립

### 9.3 메모리 관리
- 메모리 누수 방지
- 이미지 캐시 관리
- 백그라운드 태스크 최적화

## 10. 테스트 요구사항

### 10.1 단위 테스트
- 비즈니스 로직 테스트
- API 호출 테스트
- 상태 관리 테스트

### 10.2 위젯 테스트
- UI 컴포넌트 테스트
- 사용자 상호작용 테스트

### 10.3 통합 테스트
- 전체 사용자 플로우 테스트
- API 통합 테스트

## 11. 향후 확장 계획

### 11.1 1단계 (현재)
- 기본 인증 시스템
- 게시물 CRUD
- 카테고리 시스템

### 11.2 2단계 (추후)
- 댓글 시스템
- 좋아요/북마크 기능
- 알림 시스템
- 실시간 채팅

### 11.3 3단계 (장기)
- 파일 업로드
- 이미지 처리
- 다국어 지원
- 다크모드

## 12. 배포 및 운영

### 12.1 배포 환경
- 개발 환경 (Development)
- 스테이징 환경 (Staging)  
- 프로덕션 환경 (Production)

### 12.2 CI/CD
- 자동 빌드 및 테스트
- 코드 품질 검사
- 자동 배포 파이프라인

### 12.3 모니터링
- 앱 성능 모니터링
- 크래시 리포팅
- 사용자 행동 분석

## 13. 결론

이 PRD는 Nodove Community Flutter 앱의 전체 기능과 백엔드 API 요구사항을 정의합니다. 백엔드 개발팀은 이 명세서를 기반으로 필요한 API들을 구현해야 하며, 특히 인증 시스템과 게시물 관리 API의 우선 구현이 필요합니다.

각 API는 RESTful 설계 원칙을 따르며, 적절한 HTTP 상태 코드와 에러 처리를 포함해야 합니다. 또한 API 문서화와 테스트 환경 제공이 권장됩니다.