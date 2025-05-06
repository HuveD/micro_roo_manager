# Tool Usage Guide

A minimal guide with one-line descriptions and usage examples for each tool and all their options.

---

## search_files
- Search for text/code using regex in a directory.
- Example (with file_pattern):
```xml
<search_files>
  <path>src</path>
  <regex>TODO|FIXME</regex>
  <file_pattern>*.ts</file_pattern>
</search_files>
```
- Example (without file_pattern):
```xml
<search_files>
  <path>src</path>
  <regex>TODO|FIXME</regex>
</search_files>
```

## apply_diff
- Apply a code diff to a file.
- Example:
```xml
<apply_diff>
  <path>src/app.js</path>
  <diff>
    <<<<<<< SEARCH
    function authenticate(user, password) {
      // Original authentication logic
      return user.password === password;
    }
    =======
    function authenticate(user, password) {
      // EXPLANATION: 아래 코드는 Observer 패턴을 적용하여 인증 과정을 분리합니다.
      // 인증 성공/실패 시 알림을 보낼 수 있도록 구조를 개선했습니다.
      const isAuthenticated = user.password === password;
      notifyObservers(user, isAuthenticated);
      return isAuthenticated;
    }
    >>>>>>> REPLACE
  </diff>
</apply_diff>
```

## read_file
- Read all or part of a file.
- Example (read the whole file):
```xml
<read_file>
  <path>src/app.js</path>
</read_file>
```
- Example (read a specific line range):
```xml
<read_file>
  <path>src/app.js</path>
  <start_line>10</start_line>
  <end_line>500</end_line>
</read_file>
```

## execute_command
- Run a system command.
- Example (without cwd):
```xml
<execute_command>
  <command>find . -maxdepth 1 -type f -exec wc -l {} \;</command>
</execute_command>
```
- Example (with cwd):
```xml
<execute_command>
  <command>find . -maxdepth 1 -type f -exec wc -l {} \;</command>
  <cwd>src</cwd>
</execute_command>
```

## list_files
- List all files in a directory.
- Example (list files in the src directory):
```xml
<list_files>
  <path>src</path>
</list_files>
```
- Example (list files in the root directory):
```xml
<list_files>
  <path>.</path>
</list_files>
```

## Static Analysis Commands
- Always use single-run mode (never watch/auto-repeat).
- Examples:
  - `npx eslint .`
  - `flake8 .`
  - `golangci-lint run ./...`
  - `flutter analyze`
  - `./gradlew check`
  - `dotnet build`
  - `cargo clippy`
  - `./gradlew lintKotlin`
  - `swiftlint`
  - `phpstan analyse src/`

## Test Commands
- Always use single-run mode (never watch/auto-repeat).
- Examples:
  - `npm test -- --watchAll=false`
  - `pytest`
  - `go test ./...`
  - `flutter test`
  - `dotnet test`
  - `cargo test`
  - `./gradlew test`
  - `swift test`
  - `phpunit`