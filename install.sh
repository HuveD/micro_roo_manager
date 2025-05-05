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

# Copy all rules directories (preserving existing files)
echo "  ✓ Copying rules directories..."
for dir in "$EXTRACTED_DIR/docs"/*; do
  if [ -d "$dir" ]; then
    dir_name=$(basename "$dir")
    mkdir -p ".roo/$dir_name"
    cp -r "$dir"/* ".roo/$dir_name/" 2>/dev/null
    echo "    ✓ $dir_name copied"
  fi
done

# Copy other essential docs files at root level
for file in "$EXTRACTED_DIR/docs"/*.{md,json,txt}; do
  if [ -f "$file" ]; then
    file_name=$(basename "$file")
    cp "$file" ".roo/" 2>/dev/null
    echo "    ✓ $file_name copied"
  fi
done

# 4. Remove the tmp_micro_manager directory
echo "🧹 Cleaning up temporary files..."
rm -rf tmp_micro_manager

# 5. Remove the zip file
rm -f micro_roo_manager.zip

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully updated."