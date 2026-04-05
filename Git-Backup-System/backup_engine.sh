#!/bin/bash

# --- CONFIGURATION ---
BACKUP_DATE=$(date +%Y-%m-%d_%H-%M)
CONTAINER_NAME="favour-cloud-app"
BACKUP_DIR="$HOME/Git-Backup-System/vault"
REPO_DIR="$HOME/Git-Backup-System"

mkdir -p $BACKUP_DIR

echo "🛡️ Starting Optimized Disaster Recovery for $CONTAINER_NAME..."

# 1. THE PRECISION EXTRACT: Only grab the 'Brains' (Config & Themes)
# This is much faster than grabbing the whole 869MB!
docker cp $CONTAINER_NAME:/var/www/html/config $BACKUP_DIR/config_snapshot_$BACKUP_DATE
docker cp $CONTAINER_NAME:/var/www/html/themes $BACKUP_DIR/themes_snapshot_$BACKUP_DATE

# 2. THE COMPRESS: Zip the small, vital parts
tar -czf $BACKUP_DIR/cloud_core_$BACKUP_DATE.tar.gz -C $BACKUP_DIR config_snapshot_$BACKUP_DATE themes_snapshot_$BACKUP_DATE
rm -rf $BACKUP_DIR/config_snapshot_$BACKUP_DATE $BACKUP_DIR/themes_snapshot_$BACKUP_DATE

# 3. THE GIT AUTOMATION
cd $REPO_DIR
git add .
git commit -m "📦 CORE-BACKUP: Snapshot $BACKUP_DATE [Optimized Payload]"
git push origin main

echo "✅ Optimized Recovery Point Pushed to GitHub!"

