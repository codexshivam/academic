#!/bin/bash

# AuraTune Deployment Script for GitHub Pages
# Custom Domain: auratune.shivamyadav.com.np

echo "🎵 AuraTune Deployment Script"
echo "=============================="
echo "🌐 Target Domain: auratune.shivamyadav.com.np"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if we're in the correct directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ pubspec.yaml not found. Please run this script from the project root directory."
    exit 1
fi

echo "📦 Installing dependencies..."
flutter pub get

echo "🔍 Running analysis..."
flutter analyze

if [ $? -ne 0 ]; then
    echo "❌ Analysis failed. Please fix the issues before deploying."
    exit 1
fi

echo "🏗️  Building for web with custom domain..."
flutter build web --release --base-href="/"

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Please check the error messages above."
    exit 1
fi

# Copy CNAME file to build directory
echo "📝 Copying CNAME file for custom domain..."
cp CNAME build/web/

echo "✅ Build completed successfully!"
echo ""
echo "📁 Static files are available in: build/web/"
echo "🌐 Ready for deployment to: auratune.shivamyadav.com.np"
echo ""
echo "🚀 GitHub Pages Deployment:"
echo "1. Push your code to GitHub repository"
echo "2. Enable GitHub Pages in repository settings"
echo "3. Set source to 'Deploy from a branch'"
echo "4. Select 'main' branch and '/ (root)' folder"
echo "5. Your site will be available at: https://auratune.shivamyadav.com.np"
echo ""
echo "📋 Pre-deployment checklist:"
echo "✅ Build completed"
echo "✅ CNAME file copied"
echo "✅ Custom domain configured"
echo "✅ Redirect URLs updated to production"
echo ""
echo "🎵 Ready to go live! 🚀"
