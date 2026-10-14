# 현장 사진대지 (웹앱 MVP)

건설 현장 점검 사진을 찍고, 사진 위에 표시하고, 하단에 위치·내용·조치를 입력해
사진마다 한 장씩(건별 JPG/PDF) 또는 A4 1매 2장 구성 PDF로 발행하는 앱입니다.
앱 주소: https://kksyor-cloud.github.io/photo-ledger/

## 구성
- `src/app.html` — 앱 전체(화면, 저장, 마킹, 음성 입력, JPG/PDF 생성). 외부 라이브러리 없음.
- `src/sw.js`, `src/manifest.webmanifest`, `src/icon*` — 오프라인 동작과 홈 화면 설치용.
- `build.sh` — `docs/`에 설치형 웹앱(PWA)을 만듭니다: `sh build.sh` (GitHub Pages가 `docs/`를 그대로 서비스)
- `docs/` — 빌드 결과물. 앱 주소: https://kksyor-cloud.github.io/photo-ledger/

## 기획서 대비 결정
- 기획서는 Flutter 앱을 권장했지만, 설치 없이 휴대폰에서 바로 써 볼 수 있도록 MVP를 웹앱(PWA)으로 먼저 만들었습니다.
  저장 구조(점검 건 / 사진 / 비율 좌표 마킹)는 기획서 7장과 같아서 Flutter로 옮길 때 그대로 씁니다.
- 데이터는 기기 안(IndexedDB)에만 저장합니다. 클라우드 백업은 2단계.
- 음성 입력은 브라우저 음성 인식(ko-KR)을 쓰고, 안 되는 환경에서는 키보드 마이크 입력을 안내합니다.
- PDF는 A4(150dpi) 페이지를 이미지로 그려 넣는 방식이라 글꼴 내장 없이 한글이 깨지지 않습니다.

## 로컬 실행
    sh build.sh && cd docs && python3 -m http.server 8000

## 안드로이드 APK
- `android/` — 위 웹앱을 WebView로 감싼 안드로이드 앱. 카메라·갤러리, 한국어 음성 입력(구글 음성 인식 창), 다운로드 폴더 저장과 카톡·메일 공유를 휴대폰 기능으로 연결합니다.
- main 브랜치에 올릴 때마다 GitHub Actions(`.github/workflows/android.yml`)가 APK를 만들어 [Releases](https://github.com/kksyor-cloud/photo-ledger/releases/latest)에 `photo-ledger.apk`로 올립니다.
- 서명 키(`android/app/photo-ledger.keystore`)는 개인 설치용입니다. 같은 키로 서명되어 새 버전이 기존 앱 위에 그대로 설치됩니다. Play 스토어에 올릴 때는 별도 키를 만들어야 합니다.
