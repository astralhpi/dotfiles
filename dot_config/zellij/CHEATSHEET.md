# Zellij Cheatsheet (tmux 스타일)

Prefix: `Ctrl+a`

## Pane 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `-` | 수평 분할 (아래) |
| `Ctrl+a` `\|` 또는 `\` | 수직 분할 (오른쪽) |
| `Ctrl+a` `_` | 스택 분할 |
| `Ctrl+a` `x` | 현재 pane 닫기 |
| `Ctrl+a` `z` | 현재 pane 전체화면 토글 |
| `Ctrl+a` `f` | Floating pane 토글 |
| `Ctrl+a` `o` | 다음 pane으로 이동 |
| `Ctrl+a` `!` | Pane을 새 탭으로 분리 |
| `Ctrl+a` `{` / `}` | Pane 위치 이동 (좌/우) |
| `Ctrl+a` `.` | Pane 이름 변경 |

## Pane 포커스 이동 (vim 스타일)

| 키 | 설명 |
|---|---|
| `Ctrl+a` `h` / `←` | 왼쪽 pane |
| `Ctrl+a` `j` / `↓` | 아래 pane |
| `Ctrl+a` `k` / `↑` | 위 pane |
| `Ctrl+a` `l` / `→` | 오른쪽 pane |

## Tab 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `c` | 새 탭 |
| `Ctrl+a` `,` | 탭 이름 변경 |
| `Ctrl+a` `n` | 다음 탭 |
| `Ctrl+a` `p` | 이전 탭 |
| `Ctrl+a` `1-9` | 탭 번호로 이동 |
| `Ctrl+a` `Tab` | 마지막 탭으로 전환 |
| `Ctrl+a` `&` | 현재 탭 닫기 |

## Resize 모드

`Ctrl+a` `r` 로 진입

| 키 | 설명 |
|---|---|
| `h` / `←` | 왼쪽으로 확대 |
| `j` / `↓` | 아래로 확대 |
| `k` / `↑` | 위로 확대 |
| `l` / `→` | 오른쪽으로 확대 |
| `H/J/K/L` | 반대 방향으로 축소 |
| `=` / `+` | 전체 확대 |
| `-` | 전체 축소 |
| `Esc` / `Enter` | 모드 종료 |

## Scroll/Copy 모드

`Ctrl+a` `[` 로 진입 (tmux copy-mode와 동일)

| 키 | 설명 |
|---|---|
| `j` / `k` | 한 줄 스크롤 |
| `d` / `u` | 반 페이지 스크롤 |
| `Ctrl+f` / `Ctrl+b` | 한 페이지 스크롤 |
| `g` | 맨 위로 |
| `G` | 맨 아래로 |
| `/` | 검색 |
| `n` / `N` | 다음/이전 검색 결과 |
| `e` | nvim으로 scrollback 열기 |
| `q` / `Esc` | 모드 종료 |

## Session 관리

| 키 | 설명 |
|---|---|
| `Ctrl+a` `d` | Detach (백그라운드로) |
| `Ctrl+a` `w` | Session manager 열기 |

## 기타

| 키 | 설명 |
|---|---|
| `Ctrl+a` `Ctrl+a` | 실제 Ctrl+a 전송 |
| `Ctrl+a` `s` | Sync 모드 (모든 pane에 동시 입력) |
| `Ctrl+a` `Space` | 레이아웃 전환 |
| `Ctrl+a` `Ctrl+l` | Scrollback 클리어 |
| `Ctrl+a` `q` | Zellij 종료 |
| `Ctrl+a` `?` | 도움말 |

## CLI 명령어

```bash
# 새 세션
zellij

# 이름 지정 세션
zellij -s mysession

# 세션 목록
zellij list-sessions
zellij ls

# 세션 연결
zellij attach mysession
zellij a mysession

# 레이아웃으로 시작
zellij --layout compact
```
