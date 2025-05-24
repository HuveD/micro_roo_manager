#!/bin/bash

# micro_roo_manager installation script
echo "🚀 Starting micro_roo_manager installation..."

# 1. Download the repository zip
echo "⬇️ Downloading repository zip..."
# Add cache busting parameter with current timestamp
TIMESTAMP=$(date +%s)
# Direct download from add branch
curl -L -o micro_roo_manager.zip "https://github.com/HuveD/micro_roo_manager/archive/refs/heads/add.zip?_cb=$TIMESTAMP"

# 2. Create tmp_micro_manager directory and extract there
echo "📂 Extracting to tmp_micro_manager..."
mkdir -p tmp_micro_manager
unzip -q micro_roo_manager.zip -d tmp_micro_manager

# Move to extracted directory (add branch)
EXTRACTED_DIR="tmp_micro_manager/micro_roo_manager-add"

# Debug: List the extracted docs directory structure to verify content
echo "📋 Verifying extracted contents:"
find "$EXTRACTED_DIR/docs" -type f | sort

# 3. 다운로드한 임시 디렉토리 내에서 공통 문서 동기화 진행
echo "🔄 공통 문서를 각 모드 폴더로 복사하는 중..."
if [ -f "$EXTRACTED_DIR/scripts/sync_common_docs.sh" ]; then
  # 임시 폴더 내의 스크립트 실행 (기본 경로를 EXTRACTED_DIR로 설정)
  chmod +x "$EXTRACTED_DIR/scripts/sync_common_docs.sh"
  "$EXTRACTED_DIR/scripts/sync_common_docs.sh" "$EXTRACTED_DIR"
else
  echo "⚠️ 임시 폴더에 동기화 스크립트가 없습니다."
fi

# 4. .roo 디렉토리 설정
echo "🔄 Setting up .roo directory..."

# Create .roo directory if it doesn't exist (preserve existing content)
if [ ! -d ".roo" ]; then
  echo "  ✓ Creating new .roo directory..."
  mkdir -p .roo
else
  echo "  ✓ .roo directory exists, preserving existing files..."
fi

# Copy .roomodes file (if exists)
if [ -f "$EXTRACTED_DIR/.roomodes" ]; then
  cp -f "$EXTRACTED_DIR/.roomodes" .
  echo "  ✓ .roomodes copied"
fi

# 각 모드 폴더에서 필요한 문서를 .roo 폴더로 복사 (기존 파일 보존, 중복 파일만 덮어쓰기)
echo "  ✓ 각 모드 규칙 문서를 .roo 폴더로 복사 중 (기존 파일 보존)..."

# rules 폴더 복사 (plain rules 폴더)
echo "  ✓ rules 폴더 복사 중..."
if [ -d "$EXTRACTED_DIR/docs/rules" ]; then
  mkdir -p ".roo/rules"
  
  # 파일을 하나씩 확인하면서 복사
  find "$EXTRACTED_DIR/docs/rules" -type f | while read src_file; do
    rel_path="${src_file#$EXTRACTED_DIR/docs/rules/}"
    dest_file=".roo/rules/$rel_path"
    dest_dir_path=$(dirname "$dest_file")
    
    # 대상 디렉토리 생성
    mkdir -p "$dest_dir_path"
    
    # 파일 존재 여부 확인 후 복사
    if [ -f "$dest_file" ]; then
      cp -f "$src_file" "$dest_file"
      echo "    ⟳ Updated: rules/$rel_path"
    else
      cp -f "$src_file" "$dest_file"
      echo "    ✓ Added: rules/$rel_path"
    fi
  done
fi

# 모든 rules-* 디렉토리를 복사
for src_dir in "$EXTRACTED_DIR/docs/rules-"*; do
  if [ -d "$src_dir" ]; then
    dir_name=$(basename "$src_dir")
    dest_dir=".roo/$dir_name"
    
    # Create destination directory
    mkdir -p "$dest_dir"
    
    # Find and copy all files in the source directory with their subdirectory structure
    find "$src_dir" -type f -print | while read file_path; do
      rel_path="${file_path#$src_dir/}"
      
      dest_file="$dest_dir/$rel_path"
      dest_dir_path=$(dirname "$dest_file")
      
      # Create subdirectory if needed
      mkdir -p "$dest_dir_path"
      
      # Check if file exists and copy with appropriate message
      if [ -f "$dest_file" ]; then
        cp -f "$file_path" "$dest_file"
        echo "    ⟳ Updated: $dir_name/$rel_path"
      else
        cp -f "$file_path" "$dest_file"
        echo "    ✓ Added: $dir_name/$rel_path"
      fi
    done
  fi
done

# 5. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 6. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."
echo "📁 기존 개별 rules 파일들은 보존되었고, 중복 파일들은 최신 버전으로 업데이트되었습니다."