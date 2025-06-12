로컬 설정(.claude/settings.local.json)에 있는 허용 명령어 중 프로젝트 설정(.claude/settings.json)에 없는 명령어를 자동으로 추가해주세요.
`CWD`를 기준으로 검색하고 프로젝트 범위를 벗어나지 마세요.

다음 단계를 따라주세요:
1. $CWD/.claude/settings.local.json 파일의 permissions.allow 배열 읽기
2. $CWD/.claude/settings.json 파일의 permissions.allow 배열 읽기
3. 로컬에만 있고 프로젝트에 없는 명령어 찾기
4. 찾은 명령어를 프로젝트 설정에 추가
5. 프로젝트 설정 파일을 알파벳 순으로 정렬하여 저장
6. 추가된 명령어 목록을 사용자에게 보여주기

주의사항:
- 중복된 명령어는 추가하지 않습니다
- 기존 프로젝트 설정의 명령어는 절대 삭제하지 않습니다
- JSON 포맷을 유지하며 들여쓰기는 2칸을 사용합니다