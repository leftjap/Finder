"""Miller Columns 파일 탐색기 — pywebview 엔트리포인트"""

import os
import sys
import subprocess
import webview
from api import Api


def get_resource_path(filename):
    """PyInstaller 번들 또는 개발 환경에서 리소스 경로를 반환한다."""
    if getattr(sys, '_MEIPASS', None):
        return os.path.join(sys._MEIPASS, filename)
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), filename)


def apply_pending_update():
    """bin.pending\이 존재하면 updater.bat을 프로젝트 루트에 복사 후 실행하고 종료한다."""
    if getattr(sys, '_MEIPASS', None):
        # packaged: bin\_internal\ → 프로젝트 루트
        project_root = os.path.dirname(os.path.dirname(os.path.abspath(sys.executable)))
    else:
        project_root = os.path.dirname(os.path.abspath(__file__))

    pending_dir = os.path.join(project_root, "bin.pending")
    if not os.path.isdir(pending_dir):
        return

    src_bat = get_resource_path("updater.bat")
    if not os.path.isfile(src_bat):
        return

    dest_bat = os.path.join(project_root, "finder-updater.bat")
    import shutil
    shutil.copy2(src_bat, dest_bat)

    subprocess.Popen(
        ["cmd", "/c", dest_bat],
        creationflags=subprocess.CREATE_NEW_PROCESS_GROUP | subprocess.DETACHED_PROCESS,
        close_fds=True,
    )
    sys.exit(0)


def main():
    api = Api()
    window = webview.create_window(
        title="Finder",
        url=get_resource_path("index.html"),
        js_api=api,
        width=1200,
        height=700,
        min_size=(800, 400),
    )
    webview.start(
        debug=False,
        private_mode=False,
        storage_path=os.path.join(os.path.dirname(os.path.abspath(__file__)), "webview_data"),
        http_server=True,
        http_port=18904,
    )


if __name__ == "__main__":
    apply_pending_update()
    main()
