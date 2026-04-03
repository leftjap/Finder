# CLAUDE.md — finder

> 공통 실행 규칙은 opus CLAUDE.md 참조.
> 이 파일은 finder 고유 주의사항만 담는다.

## finder 고유 주의

- 코드 변경 후 PyInstaller exe 재빌드 필수
  - 빌드: `cd /c/dev/apps/finder && pyinstaller Finder.spec --distpath dist/staging && rm -rf bin.pending && mv dist/staging/Finder bin.pending && rm -rf dist/staging`
  - 실행: `C:\dev\apps\finder\bin\Finder.exe`
  - 빌드 실패 시 1회만 재시도. 2회 실패 시 사용자에게 보고하고 중단.
- favorites.json은 gitignore 대상. 런타임 자동 생성. 경로 하드코딩 금지
- api.py _is_allowed()로 경로 보안. 우회 금지
- 새 리소스 파일(html/js/css) 추가 시 PyInstaller --add-data에도 추가
- JS에서 Python API 호출은 비동기: await window.pywebview.api.함수명()
