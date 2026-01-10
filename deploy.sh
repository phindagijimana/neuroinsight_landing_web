#!/bin/bash
echo "Force deploying to GitHub Pages..."
git add .
git commit -m "Force deployment: $(date)"
git push origin main
echo "Deployment triggered. Check GitHub Actions tab."
EOF && chmod +x deploy.sh
