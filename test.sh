#!/bin/bash

# micro_roo_manager installation script
echo "🚀 Starting micro_roo_manager installation..."

# 1. Download the repository zip
echo "⬇️ Downloading repository zip..."
curl -L -o micro_roo_manager.zip https://github.com/HuveD/micro_roo_manager/archive/refs/heads/main.zip

# 2. Create tmp_micro_manager directory and extract there
echo "📂 Extracting to tmp_micro_manager..."
mkdir -p tmp_micro_manager
unzip -q micro_roo_manager.zip -d tmp_micro_manager

# Move to extracted directory (main branch)
EXTRACTED_DIR="tmp_micro_manager/micro_roo_manager-main"

# 3. Copy .roo and .roomodes to project root (preserve existing files, only overwrite updated ones)
echo "🔄 Copying .roo and .roomodes to project root (preserving existing files)..."

# Create .roo directory if it doesn't exist
mkdir -p .roo

# .roo 하위에 docs에 있는 rules-* 폴더를 모두 생성 (빈 폴더도 생성)
mkdir -p .roo/rules-deep-research-agent
mkdir -p .roo/rules-memory
mkdir -p .roo/rules-debug
mkdir -p .roo/rules-ask
mkdir -p .roo/rules-architect
mkdir -p .roo/rules-code
mkdir -p .roo/rules-orchestrator

# Copy docs directory structure with all files to .roo
echo "  ✓ Copying all directories and files from docs to .roo..."

# docs 하위의 모든 폴더와 파일을 .roo로 복사(덮어쓰기)
cp -r "$EXTRACTED_DIR/docs/." .roo/

# logs 폴더가 없으면 생성
if [ ! -d "./.roo/logs" ]; then
  mkdir ./.roo/logs
  echo "  ✓ logs 폴더 생성됨"
fi

# memory 폴더가 없으면 생성
if [ ! -d "./.roo/memory" ]; then
  mkdir ./.roo/memory
  echo "  ✓ memory 폴더 생성됨"
fi

# 4. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 5. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."
