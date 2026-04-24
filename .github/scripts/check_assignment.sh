#!/bin/bash

# check_assignment.sh - Validation script for 03-unit-control-panel

CHECK_TYPE=$1

case $CHECK_TYPE in
  "files")
    echo "Checking for required files..."
    if [ -f "index.html" ] && [ -f "style.css" ] && [ -f "README.md" ]; then
      echo "All required files exist."
      exit 0
    else
      echo "Missing one or more required files (index.html, style.css, README.md)."
      exit 1
    fi
    ;;

  "grid")
    echo "Checking for Grid Template Areas implementation..."
    if grep -q "grid-template-areas" style.css; then
      echo "Found grid-template-areas in style.css."
      exit 0
    else
      echo "Missing 'grid-template-areas' in style.css. Please use areas to define your 3x3 layout."
      exit 1
    fi
    ;;

  "feedback")
    echo "Checking for Touch Feedback (active state and scale)..."
    if grep -q ":active" style.css && grep -q "scale" style.css; then
      echo "Found :active state and transform: scale in style.css."
      exit 0
    else
      echo "Missing touch feedback. Ensure you have :active styles with a transform: scale() effect."
      exit 1
    fi
    ;;

  "hud")
    echo "Checking for FPV HUD Overlay implementation..."
    if grep -q "position: absolute" style.css && grep -q "z-index" style.css; then
      echo "Found absolute positioning and z-index usage."
      exit 0
    else
      echo "Missing HUD overlay properties. Ensure the control panel uses absolute positioning and a high z-index."
      exit 1
    fi
    ;;

  "report")
    echo "Checking Student Submission sections in README.md..."
    # Check if they replaced placeholder text in parentheticals
    if ! grep -q "(例如：" README.md && ! grep -q "(是/否)" README.md; then
       echo "Student submission content detected (placeholders removed)."
       exit 0
    else
       echo "Please fill out the 'UI 設計與觸控分析錄' section and remove placeholder text like '(例如：...)' and '(是/否)'."
       exit 1
    fi
    ;;

  *)
    echo "Usage: $0 {files|grid|feedback|hud|report}"
    exit 1
    ;;
esac
