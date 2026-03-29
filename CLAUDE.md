# Explorer — CLAUDE.md

## 프로젝트

Windows Miller Columns 파일 탐색기. Python pywebview + HTML/JS/CSS.

## 핵심 규칙

1. 코드 변경 후 exe 재빌드 필수:
   ```
   .venv\Scripts\activate
   pyinstaller Explorer.spec -y
   ```
2. favorites.json은 gitignore 대상. 런타임 자동 생성.
3. ALLOWED_PATHS는 favorites.json에서 동적 로드. 하드코딩 금지.
4. 파일 경로는 Windows 절대 경로 (`\` 구분자).
5. api.py의 _is_allowed()로 경로 보안 체크. 우회 금지.

## 파일 역할

- main.py: pywebview 엔트리포인트
- api.py: 파일시스템 API
- app.js: 프론트엔드 로직
- index.html: HTML
- style.css: CSS
