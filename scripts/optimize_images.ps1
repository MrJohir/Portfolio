# Image Optimization Script for Portfolio
# This script compresses all images in the assets folder for faster web loading
# Requirements: Python with Pillow library installed

# Colors for output
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Portfolio Image Optimization Script" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check if Python is installed
$pythonPath = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonPath) {
    Write-Host "Python is not installed. Please install Python first." -ForegroundColor $Red
    Write-Host "Download from: https://www.python.org/downloads/" -ForegroundColor $Yellow
    exit 1
}

# Check if Pillow is installed
$pillowCheck = python -c "import PIL" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Installing Pillow library..." -ForegroundColor $Yellow
    pip install Pillow
}

# Create backup folder
$assetsPath = "d:\flutter_project\Portfolio\assets"
$backupPath = "d:\flutter_project\Portfolio\assets_backup"

if (-not (Test-Path $backupPath)) {
    Write-Host "Creating backup of original images..." -ForegroundColor $Yellow
    Copy-Item -Path $assetsPath -Destination $backupPath -Recurse
    Write-Host "Backup created at: $backupPath" -ForegroundColor $Green
}

# Python script for image compression
$pythonScript = @"
import os
import sys
from PIL import Image

def optimize_image(input_path, max_width=800, max_height=1200, quality=85):
    """Optimize a single image for web"""
    try:
        with Image.open(input_path) as img:
            # Convert to RGB if necessary (for PNG with transparency)
            if img.mode in ('RGBA', 'P'):
                # Create white background for transparent images
                background = Image.new('RGB', img.size, (255, 255, 255))
                if img.mode == 'P':
                    img = img.convert('RGBA')
                background.paste(img, mask=img.split()[-1] if img.mode == 'RGBA' else None)
                img = background
            elif img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Get original size
            original_size = os.path.getsize(input_path)
            original_dimensions = img.size
            
            # Calculate new dimensions maintaining aspect ratio
            width, height = img.size
            
            # Only resize if larger than max dimensions
            if width > max_width or height > max_height:
                ratio = min(max_width / width, max_height / height)
                new_size = (int(width * ratio), int(height * ratio))
                img = img.resize(new_size, Image.Resampling.LANCZOS)
            
            # Save as optimized JPEG
            output_path = input_path
            if input_path.lower().endswith('.png'):
                output_path = input_path[:-4] + '.jpg'
                
            img.save(output_path, 'JPEG', quality=quality, optimize=True)
            
            new_size = os.path.getsize(output_path)
            reduction = ((original_size - new_size) / original_size) * 100
            
            # Remove original PNG if converted to JPG
            if output_path != input_path and os.path.exists(input_path):
                os.remove(input_path)
            
            return original_size, new_size, reduction, original_dimensions, img.size
    except Exception as e:
        print(f"Error processing {input_path}: {e}")
        return None

def process_folder(folder_path):
    """Process all images in a folder recursively"""
    total_original = 0
    total_optimized = 0
    processed = 0
    
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.lower().endswith(('.png', '.jpg', '.jpeg')):
                file_path = os.path.join(root, file)
                result = optimize_image(file_path)
                
                if result:
                    orig, new, reduction, orig_dim, new_dim = result
                    total_original += orig
                    total_optimized += new
                    processed += 1
                    
                    print(f"✓ {file}: {orig/1024:.1f}KB -> {new/1024:.1f}KB ({reduction:.1f}% reduced)")
    
    return total_original, total_optimized, processed

if __name__ == "__main__":
    folder = sys.argv[1] if len(sys.argv) > 1 else "assets"
    print(f"\nOptimizing images in: {folder}\n")
    print("-" * 60)
    
    orig, opt, count = process_folder(folder)
    
    print("-" * 60)
    print(f"\n📊 SUMMARY:")
    print(f"   Files processed: {count}")
    print(f"   Original size: {orig/1024/1024:.2f} MB")
    print(f"   Optimized size: {opt/1024/1024:.2f} MB")
    print(f"   Total reduction: {((orig-opt)/orig)*100:.1f}%")
    print(f"   Space saved: {(orig-opt)/1024/1024:.2f} MB")
"@

# Save Python script
$pythonScriptPath = "d:\flutter_project\Portfolio\optimize_images.py"
$pythonScript | Out-File -FilePath $pythonScriptPath -Encoding UTF8

Write-Host "Running image optimization..." -ForegroundColor $Yellow
Write-Host ""

# Run Python script
python $pythonScriptPath $assetsPath

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Optimization Complete!" -ForegroundColor $Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor $Yellow
Write-Host "1. Update pubspec.yaml if any .png files were converted to .jpg" -ForegroundColor White
Write-Host "2. Update app_images.dart with new file extensions if needed" -ForegroundColor White
Write-Host "3. Run 'flutter clean' and 'flutter build web'" -ForegroundColor White
Write-Host "4. Original images are backed up in: assets_backup/" -ForegroundColor White
Write-Host ""
