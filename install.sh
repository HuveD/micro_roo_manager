#!/bin/bash

# micro_roo_manager installation script
echo "🚀 Starting micro_roo_manager installation..."

# 1. Download the repository zip
echo "⬇️ Downloading repository zip..."
# Add cache busting parameter with current timestamp
TIMESTAMP=$(date +%s)
curl -L -o micro_roo_manager.zip "https://github.com/HuveD/micro_roo_manager/archive/refs/heads/add.zip?_cb=$TIMESTAMP"

# 2. Create tmp_micro_manager directory and extract there
echo "📂 Extracting to tmp_micro_manager..."
mkdir -p tmp_micro_manager
unzip -q micro_roo_manager.zip -d tmp_micro_manager

# Move to extracted directory (add branch)
EXTRACTED_DIR="tmp_micro_manager/micro_roo_manager-add"

# Display commit information if git info is available
if [ -f "$EXTRACTED_DIR/.git/HEAD" ]; then
  echo "📋 Repository information:"
  cat "$EXTRACTED_DIR/.git/HEAD"
fi

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

# 4. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 5. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."