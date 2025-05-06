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

# Copy .roomodes file (if exists)
if [ -f "$EXTRACTED_DIR/.roomodes" ]; then
  cp "$EXTRACTED_DIR/.roomodes" .
  echo "  ✓ .roomodes copied"
fi

# Copy docs directory structure with all files to .roo
echo "  ✓ Copying all directories and files from docs to .roo..."

# docs 하위의 모든 폴더와 파일을 .roo로 복사(덮어쓰기)
cp -r "$EXTRACTED_DIR/docs/." .roo/

# 4. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 5. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."