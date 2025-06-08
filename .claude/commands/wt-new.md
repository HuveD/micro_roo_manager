$ARGUMENTS에 대한 새 브랜치와 git worktree를 생성해주세요.

다음 단계를 따라주세요:
1. 사용자의 설명을 분석하여 적절한 브랜치명 결정
   - feature/기능명: 새로운 기능 추가
   - fix/이슈명: 버그 수정
   - refactor/대상: 리팩토링
   - docs/문서명: 문서 작업
   - test/테스트명: 테스트 작업
   - chore/작업명: 기타 작업

2. 브랜치명 생성 규칙
   - 소문자와 하이픈(-) 사용
   - 간결하고 명확한 이름
   - 예: feature/user-authentication, fix/login-error

3. worktree 생성
   - 현재 브랜치 상태 확인
   - ../vokki_app_[브랜치명] 경로에 worktree 생성
   - 새 브랜치는 현재 브랜치를 기반으로 생성

4. 실행할 명령어
   ```bash
   # 현재 상태 확인
   git status
   git branch --show-current
   
   # 새 브랜치와 함께 worktree 생성
   git worktree add -b [브랜치명] ../vokki_app_[브랜치명]
   
   # 생성된 worktree 목록 확인
   git worktree list
   ```

5. 생성 완료 후 안내
   - 새 worktree 경로 알려주기
   - 해당 디렉토리로 이동하는 방법 안내
   - worktree 제거 방법도 간단히 설명

주의사항:
- 이미 존재하는 브랜치명은 사용하지 않습니다
- worktree 경로가 이미 존재하는지 확인합니다
- 커밋되지 않은 변경사항이 있으면 경고합니다