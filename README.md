# Linux System Health Monitor 🚀

A lightweight Bash script that automates system health checks using Cron Jobs.

## 🛠️ Features
- **CPU Monitoring**: Tracks real-time load.
- **RAM Tracking**: Monitors free memory with threshold alerts.
- **Disk Usage**: Keeps an eye on storage.
- **Automation**: Fully automated logging every minute.

## 🚀 How it works
The script is scheduled via `crontab` and appends system statistics to `health_log.txt`.
