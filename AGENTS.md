# Explorer — AGENTS.md

> Opus용 프로젝트 규칙. Haiku용은 CLAUDE.md.

## 개요

Windows 전용 Miller Columns 파일 탐색기. Python(pywebview) + HTML/JS/CSS.

## 파일 구조

| 파일 | 역할 |
|---|---|
| main.py | pywebview 엔트리포인트 |
| api.py | 파일시스템 API (pywebview expose) |
| app.js | 프론트엔드 로직 |
| index.html | HTML 구조 |
| style.css | 스타일 |
| icon.ico | 앱 아이콘 |
| favorites.json | 사이드바 즐겨찾기 (런타임 생성, gitignore) |

## 빌드

- **도구:** PyInstaller (onefile, noconsole)
- **빌드 명령:**
  ```
  .venv\Scripts\activate
  pyinstaller --onefile --noconsole --name Explorer --icon icon.ico --add-data "index.html;." --add-data "app.js;." --add-data "style.css;." main.py
  ```
- **출력:** `dist\Explorer\Explorer.exe`
- ⚠️ **코드 변경 후 exe 재빌드 필수.** exe는 번들된 코드를 사용하므로 소스 수정만으로는 반영되지 않음.

## 배포 규칙

- 모든 작업지시서의 커밋 Step 앞에 exe 재빌드 Step을 포함한다.
- `.spec` 파일이 존재하면 `pyinstaller Explorer.spec -y`로 빌드.

## 소스 참조

- 크롤링 제외: 없음 (전체 파일 크롤링 가능)
- GitHub raw 베이스: `https://raw.githubusercontent.com/leftjap/explorer/main/`

## 고위험 함수

없음 (현재 규모 소형)
