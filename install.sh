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

# 3. Copy .roo and .roomodes to project root (force overwrite existing files)
echo "🔄 Copying .roo and .roomodes to project root (overwriting existing files)..."

# Remove existing .roo directory if it exists
if [ -d ".roo" ]; then
  echo "  ✓ Removing existing .roo directory..."
  rm -rf .roo
fi

# Create .roo directory
mkdir -p .roo

# Copy .roomodes file (if exists)
if [ -f "$EXTRACTED_DIR/.roomodes" ]; then
  cp -f "$EXTRACTED_DIR/.roomodes" .
  echo "  ✓ .roomodes copied"
fi

# Copy docs directory structure with all files to .roo
echo "  ✓ Copying all directories and files from docs to .roo..."

# First, copy top-level files in docs directly to .roo root
for file in "$EXTRACTED_DIR/docs"/*; do
  if [ -f "$file" ]; then
    file_name=$(basename "$file")
    cp -f "$file" ".roo/" 2>/dev/null
    echo "    ✓ Copied: $file_name to .roo/"
  fi
done

# Copy scripts directory
echo "  ✓ Copying scripts directory..."
mkdir -p scripts
cp -f "$EXTRACTED_DIR/scripts/sync_common_docs.sh" "scripts/" 2>/dev/null
chmod +x scripts/sync_common_docs.sh

# Then copy all subdirectories from docs to .roo with their complete structure
for src_dir in "$EXTRACTED_DIR/docs"/*; do
  if [ -d "$src_dir" ]; then
    dir_name=$(basename "$src_dir")
    dest_dir=".roo/$dir_name"
    
    # Create destination directory
    mkdir -p "$dest_dir"
    
    # Find and copy all files in the source directory with their subdirectory structure
    if [ -d "$src_dir" ]; then
      # Copy using find to preserve subdirectory structure
      find "$src_dir" -type f -print | while read file_path; do
        rel_path="${file_path#$src_dir/}"
        
        # If the relative path is empty, it's a file directly in src_dir
        if [ -z "$rel_path" ]; then
          rel_path=$(basename "$file_path")
        fi
        
        dest_file="$dest_dir/$rel_path"
        dest_dir_path=$(dirname "$dest_file")
        
        # Create subdirectory if needed
        mkdir -p "$dest_dir_path"
        
        # Copy the file with force overwrite
        cp -f "$file_path" "$dest_file"
        echo "    ✓ Copied: $dir_name/$rel_path"
      done
    fi
  fi
done

# 4. 공통 문서 동기화 수행 (docs/common의 문서를 각 역할별 폴더로 복사)
echo "🔄 동기화: 공통 문서를 각 모드 폴더로 동기화하는 중..."
if [ -f "scripts/sync_common_docs.sh" ]; then
  ./scripts/sync_common_docs.sh
  echo "  ✓ 공통 문서 동기화 완료"
fi

# 5. 다운로드한 .roo 디렉토리에도 동기화된 문서 복사
echo "  ✓ .roo 디렉토리에 동기화된 문서 복사 중..."
for src_dir in "docs"/*; do
  if [ -d "$src_dir" ] && [ "$(basename "$src_dir")" != "common" ]; then
    dir_name=$(basename "$src_dir")
    dest_dir=".roo/$dir_name"
    
    # Find and copy all files in the source directory
    find "$src_dir" -type f -print | while read file_path; do
      rel_path="${file_path#$src_dir/}"
      
      # If the relative path is empty, it's a file directly in src_dir
      if [ -z "$rel_path" ]; then
        rel_path=$(basename "$file_path")
      fi
      
      dest_file="$dest_dir/$rel_path"
      dest_dir_path=$(dirname "$dest_file")
      
      # Create subdirectory if needed
      mkdir -p "$dest_dir_path"
      
      # Copy the file with force overwrite
      cp -f "$file_path" "$dest_file"
    done
  fi
done

# 6. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 7. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."