// Image Optimization Guide for Portfolio
// ========================================
// 
// Your images are TOO LARGE! Here's the issue:
// 
// CURRENT SIZES (Total: 42+ MB):
// - profile.png: 6.2 MB (should be < 200 KB)
// - hamdan4.png: 4.0 MB (should be < 150 KB)
// - roman1.png: 3.1 MB (should be < 150 KB)
// - Many others: 1-3 MB each
//
// TARGET SIZES for web:
// - Profile image: < 200 KB (max 800x1000 pixels)
// - Mobile screenshots: < 150 KB each (max 400x800 pixels)
// - Background: < 100 KB (can use WebP)
//
// ========================================
// OPTION 1: Use Online Tools (Easiest)
// ========================================
//
// 1. Go to https://squoosh.app/ (Google's image optimizer)
// 2. Drag each image and compress to:
//    - Format: WebP or JPEG
//    - Quality: 80-85%
//    - Resize: Max width 800px for mobile screenshots
// 3. Replace files in assets folder
//
// ========================================
// OPTION 2: Use TinyPNG (Bulk)
// ========================================
//
// 1. Go to https://tinypng.com/
// 2. Upload up to 20 images at a time
// 3. Download compressed versions
// 4. Replace in assets folder
//
// ========================================
// OPTION 3: Use ImageMagick (Command Line)
// ========================================
//
// Install: https://imagemagick.org/script/download.php
// Then run in PowerShell:
//
// # For each PNG file, compress and resize:
// Get-ChildItem -Path "assets" -Recurse -Filter "*.png" | ForEach-Object {
//     magick $_.FullName -resize "800x1200>" -quality 85 $_.FullName
// }
//
// ========================================
// RECOMMENDED IMAGE SIZES
// ========================================
//
// | Image Type        | Max Width | Max Height | Max Size |
// |-------------------|-----------|------------|----------|
// | Profile Photo     | 800px     | 1000px     | 200 KB   |
// | Mobile Screenshot | 400px     | 800px      | 150 KB   |
// | Background        | 1200px    | 800px      | 100 KB   |
// | Tech Logos        | 100px     | 100px      | 10 KB    |
//
// ========================================
// AFTER COMPRESSING
// ========================================
//
// 1. Run: flutter clean
// 2. Run: flutter build web --release
// 3. Deploy to Netlify
//
// Expected result: Total assets < 5 MB (was 42 MB)
// Load time improvement: 5-10x faster!
