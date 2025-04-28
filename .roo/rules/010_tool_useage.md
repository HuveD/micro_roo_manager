# 도구 사용 지침 (Tool Usage Instructions)

## 핵심 규칙: 도구 호출 형식 (Core Rule: Tool Call Format)

- 도구를 호출해야 할 경우, **반드시** 아래 명시된 XML 형식을 따라야 합니다.
- **실제 도구 이름**(예: `read_file`, `search_web`)을 **최상위 XML 태그**로 사용해야 합니다. `<tool_name>`과 같은 플레이스홀더 태그를 사용해서는 **안 됩니다.**
- 각 매개변수는 해당 도구 태그 내부에 **자식 XML 태그**로 포함되어야 하며, 태그 이름은 **매개변수 이름**(예: `path`, `query`)이어야 합니다.

## 정확한 형식 예시 (Correct Format Example)

**올바른 형식:** `read_file` 도구를 `path` 매개변수와 함께 호출하는 경우

```xml
<read_file>
<path>docs/tech/refactoring/quiz_screen_refactoring_plan.md</path>
</read_file>
```

**올바른 형식:** `search_web` 도구를 `query` 매개변수와 함께 호출하는 경우

```xml
<search_web>
<query>최신 AI 기술 동향</query>
</search_web>
```

**잘못된 형식 (이렇게 사용하지 마세요):**

```xml
<!-- 잘못된 예시 1: <tool_name> 태그 사용 -->
<tool_name>read_file</tool_name>
<path>docs/tech/refactoring/quiz_screen_refactoring_plan.md</path>

<!-- 잘못된 예시 2: 매개변수가 부모 태그 외부에 있음 -->
<read_file />
<path>docs/tech/refactoring/quiz_screen_refactoring_plan.md</path>
```

## 주요 툴 지침

### apply_diff

```text
<<<<<<< SEARCH  
:start_line:10  
:end_line:12  
-------  
// Old calculation logic  
const result = value * 0.9;  
return result;  
=======  
// Updated calculation logic with logging  
console.log(`Calculating for value: ${value}`);  
const result = value * 0.95; // Adjusted factor  
return result;  
>>>>>>> REPLACE  
  
<<<<<<< SEARCH  
:start_line:25  
:end_line:25  
-------  
const defaultTimeout = 5000;  
=======  
const defaultTimeout = 10000; // Increased timeout  
>>>>>>> REPLACE
```

#### 주의사항

- `start_line`이 있다면 `end_line`도 꼭 지정합니다.
- `apply_diff` 툴이 실패하는 경우 아래 절차에 따라 대체 시도를 진행합니다.

 1. `read_file`로 최신 파일 상태 확인 후 재시도
 2. 그래도 오류 발생 시 `write_to_file` 사용

## 지침 요약

- 도구 호출 시: **`<실제_도구_이름><매개변수1_이름>값1</매개변수1_이름><매개변수2_이름>값2</매개변수2_이름>...</실제_도구_이름>`** 형식을 엄격히 준수하십시오.
- **`<tool_name>` 태그는 절대 사용하지 마십시오.** 실제 호출하려는 도구의 이름을 태그로 사용해야 합니다.
