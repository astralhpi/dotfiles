# tmux Cheatsheet

Prefix: `Ctrl+a`

## Pane 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `\|` 또는 `\` | 세로 분할 (오른쪽) |
| `Ctrl+a` `-` | 가로 분할 (아래) |
| `Ctrl+a` `x` | 현재 pane 닫기 |
| `Ctrl+a` `z` | 현재 pane 줌 토글 |
| `Ctrl+a` `!` | Pane을 새 윈도우로 분리 |
| `Ctrl+a` `{` / `}` | Pane 위치 스왑 |
| `Ctrl+a` `s` | Pane 동기화 토글 (모든 pane에 동시 입력) |

## Pane 이동 (vim 스타일)

| 키 | 설명 |
|---|---|
| `Ctrl+a` `h` | 왼쪽 pane |
| `Ctrl+a` `j` | 아래 pane |
| `Ctrl+a` `k` | 위 pane |
| `Ctrl+a` `l` | 오른쪽 pane |

## Pane 리사이즈

| 키 | 설명 |
|---|---|
| `Ctrl+a` `H` | 왼쪽으로 5칸 |
| `Ctrl+a` `J` | 아래로 5칸 |
| `Ctrl+a` `K` | 위로 5칸 |
| `Ctrl+a` `L` | 오른쪽으로 5칸 |

## Window (탭) 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `c` | 새 윈도우 |
| `Ctrl+a` `,` | 윈도우 이름 변경 |
| `Ctrl+a` `n` | 다음 윈도우 |
| `Ctrl+a` `p` | 이전 윈도우 |
| `Ctrl+a` `1-9` | 윈도우 번호로 이동 |
| `Ctrl+a` `Tab` | 마지막 윈도우로 전환 |
| `Ctrl+a` `<` / `>` | 윈도우 순서 변경 |
| `Ctrl+a` `&` | 현재 윈도우 닫기 |

## Copy 모드 (vim 스타일)

`Ctrl+a` `[` 로 진입

| 키 | 설명 |
|---|---|
| `j` / `k` | 한 줄 스크롤 |
| `Ctrl+d` / `Ctrl+u` | 반 페이지 스크롤 |
| `Ctrl+f` / `Ctrl+b` | 한 페이지 스크롤 |
| `g` | 맨 위로 (gg) |
| `G` | 맨 아래로 |
| `v` | 선택 시작 |
| `V` | 줄 선택 |
| `y` | 복사 |
| `/` / `?` | 검색 (아래/위) |
| `n` / `N` | 다음/이전 검색 결과 |
| `q` / `Esc` | 모드 종료 |

## Session 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `d` | Detach (백그라운드로) |
| `Ctrl+a` `w` | 세션/윈도우 트리 |
| `Ctrl+a` `N` | 새 세션 |
| `Ctrl+a` `m` | 마지막 세션으로 전환 |
| `Ctrl+a` `$` | 세션 이름 변경 |

## 유틸리티

| 키 | 설명 |
|---|---|
| `Ctrl+a` `P` | Command Palette (fzf) |
| `Ctrl+a` `Ctrl+f` | tmux-fzf 메뉴 |
| `Ctrl+a` `f` | Floating popup 터미널 |
| `Ctrl+a` `g` | Lazygit popup |
| `Ctrl+a` `Space` | 레이아웃 순환 |
| `Ctrl+a` `Ctrl+l` | Scrollback 클리어 |
| `Ctrl+a` `r` | 설정 리로드 |
| `Ctrl+a` `Ctrl+a` | 실제 Ctrl+a 전송 |

## 세션 저장/복구 (tmux-resurrect)

| 키 | 설명 |
|---|---|
| `Ctrl+a` `Ctrl+s` | 세션 저장 |
| `Ctrl+a` `Ctrl+r` | 세션 복구 |

## URL/텍스트 추출

| 키 | 설명 |
|---|---|
| `Ctrl+a` `u` | 화면의 URL 선택해서 열기 |
| `Ctrl+a` `Tab` | 화면에서 텍스트 선택해서 복사/삽입 |

## CLI 명령어

```bash
# 새 세션
tmux

# 이름 지정 세션
tmux new -s mysession

# 세션 목록
tmux ls

# 세션 연결
tmux attach -t mysession
tmux a -t mysession

# 세션 종료
tmux kill-session -t mysession
tmux kill-server  # 모든 세션 종료
```

## tmuxp (세션 관리)

```bash
# 저장된 세션 로드
tmuxp load dotfiles
tmuxp load chat

# 세션 설정 위치
~/.config/tmuxp/*.yaml
```
