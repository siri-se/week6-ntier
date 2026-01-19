### README.md 

```markdown
# 📋 Task Board - N-Tier Architecture (Week 6)

## 🏗️ Architecture

```
Browser → Nginx (HTTPS) → Node.js (API) → PostgreSQL (Data)
```

## 🚀 Quick Start

```bash
# Start all services
./scripts/start-all.sh

# Access
https://taskboard.local
```

## 📁 Project Structure

```
week6-ntier/
├── src/           # Backend source code
├── public/        # Frontend files
├── database/      # SQL scripts
├── nginx/         # Nginx config
└── scripts/       # Helper scripts
```

## 🛠️ Technologies

| Tier | Technology |
|------|------------|
| Web Server | Nginx |
| Backend | Node.js + Express |
| Database | PostgreSQL |

## 👨‍💻 Author

[Your Name] - ENGSE207 Week 6
```

---

## 🛠️ แก้ปัญหาเบื้องต้น

### PostgreSQL
```bash
# ตรวจสอบ status
sudo systemctl status postgresql

# ดู logs
sudo tail -50 /var/log/postgresql/postgresql-*-main.log

# Reset password
sudo -u postgres psql -c "ALTER USER taskboard PASSWORD 'taskboard123';"
```

### Nginx
```bash
# Test config
sudo nginx -t

# ดู logs
sudo tail -f /var/log/nginx/taskboard_error.log

# Restart
sudo systemctl restart nginx
```

### Node.js
```bash
# ดู PM2 logs
pm2 logs taskboard-api

# Restart
pm2 restart taskboard-api

# ดู process
pm2 show taskboard-api
```

---
