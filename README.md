# mac_init_setup

새 맥(Apple Silicon)을 초기 세팅하는 스크립트. Homebrew · 개발 도구 · 앱 · 셸 설정(`.zshrc`, starship, wezterm, tmux)을 한 번에 설치·구성한다.

## 요구 사항

- macOS (Apple Silicon, `/opt/homebrew` 기준)
- 인터넷 연결
- 관리자 권한 (일부 `sudo` 단계)

## 사용법

이 저장소를 홈 아래 `~/Development/mac_init_setup` 경로로 받는다. (스크립트가 이 경로를 참조해 설정 파일을 복사한다.)

```bash
git clone git@github-personal:economyjang/mac_init_setup.git ~/Development/mac_init_setup
cd ~/Development/mac_init_setup
bash run_init_setting.sh
```

> 설치 도중 Homebrew·`sudo` 비밀번호 입력 프롬프트가 뜰 수 있다.

## 설치되는 것

### 개발 언어 / 버전 관리
- `fnm` — Node 버전 관리자 (설치 시 최신 LTS를 기본으로 지정)
- `pyenv`, `pyenv-virtualenv` — Python 버전·가상환경 관리
- `yarn` — npm 전역 설치
- `bun` — 공식 설치 스크립트로 `~/.bun`에 설치 (claude-mem 플러그인 실행에 필요)

### CLI 유틸리티
| 도구 | 용도 |
|------|------|
| `bat` | 문법 강조 `cat` |
| `fzf` | 퍼지 검색 (Ctrl+R 등) |
| `eza` | 아이콘·색상 `ls` (다수 alias) |
| `ripgrep` | 초고속 grep (`rg`) |
| `tree` | 폴더 트리 출력 |
| `zoxide` | 학습형 `cd` (`z`) |
| `zsh-autosuggestions` | 명령어 자동완성 힌트 |
| `zsh-syntax-highlighting` | 명령어 색상 강조 |
| `starship` | 셸 프롬프트 |
| `neovim` | 에디터 |
| `git` | 최신 git |
| `libpq` | PostgreSQL 클라이언트 (`psql` 등) |
| `tmux` | 터미널 멀티플렉서 |

### 애플리케이션 (Homebrew Cask)
- 폰트: `font-fira-code-nerd-font`
- 개발: `orbstack`, `visual-studio-code`, `cursor`, `postman`, `beekeeper-studio`, `another-redis-desktop-manager`
- 터미널: `wezterm`
- 생산성: `notion`, `obsidian`, `slack`, `raycast`, `google-chrome`
- AI: `chatgpt`, `claude`
- Claude Code CLI — 공식 설치 스크립트로 `~/.local/bin`에 설치

### 셸 · 앱 설정
- `.zshrc` 생성 (Homebrew / pyenv / fnm / yarn / eza alias / zoxide / starship / fzf / git 커스텀 함수 / Claude Code · Bun · PostgreSQL PATH)
- starship 설정 → `~/.config/starship/`
- wezterm 설정 → `~/.wezterm.lua`
- tmux 설정 → `~/.tmux.conf`
- macOS Dock 자동 숨김 속도 조정, `~/.hushlogin`

## 설치 후 수동 작업

스크립트로 자동화되지 않는 GUI/계정 단계:

- **Raycast** — 첫 실행 후 접근성 권한 허용, 핫키를 `⌘+Space`로 쓰려면 *시스템 설정 > 키보드 > 단축키 > Spotlight*에서 Spotlight 단축키를 먼저 해제
- **앱 로그인** — Chrome, Notion, Obsidian, Slack, ChatGPT, Claude, Cursor 등
- **SSH 키** — GitHub 등에 공개키 등록 (계정별로 `~/.ssh/config`의 Host 별칭 사용)
- **JetBrains 등 라이선스** — 필요 시 별도 설치·로그인

## 구성

```
.
├── run_init_setting.sh   # 메인 설치 스크립트
├── starship/             # starship 프롬프트 설정
├── wezterm/              # wezterm 터미널 설정
└── tmux/                 # tmux 설정
```
