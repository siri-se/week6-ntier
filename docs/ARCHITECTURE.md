# Task Board – Week 6 N-Tier Architecture

ENGSE207 – Software Architecture  
Week 6: N-Tier Architecture Lab

---

## Overview
โปรเจกต์นี้เป็นระบบ Task Board ที่พัฒนาโดยใช้แนวคิด  
N-Tier Architecture ร่วมกับ Layered Architecture

จุดประสงค์คือเพื่อแยกความรับผิดชอบของระบบออกเป็นแต่ละ Tier และ Layer  
เพื่อเพิ่ม Maintainability, Scalability และ Security ของระบบ

---

## Architecture Style
- N-Tier Architecture
- Layered Architecture
- RESTful API
- Reverse Proxy (Nginx)
- HTTPS (SSL)

---

## System Architecture (High Level)
```
Client (Browser)
|
v
Nginx (Reverse Proxy, HTTPS)
|
v
Node.js / Express (API Server)
|
v
PostgreSQL Database
```
---
## Project Structure
```
week6-ntier/
├── public/ 
│ ├── index.html
│ ├── css/
│ └── js/
│
├── src/
│ ├── controllers/ 
│ ├── services/ 
│ ├── repositories/ 
│ ├── models/ 
│ ├── routes/ 
│ ├── middleware/
│ └── config/ 
│
├── database/ 
│ └── init.sql
│
├── nginx/ 
│ └── taskboard.conf
│
├── scripts/ 
│ ├── setup.sh
│ ├── start-all.sh
│ └── test-api.sh
│
├── docs/
│ ├── ANALYSIS.md
│ └── ARCHITECTURE.md
│
├── server.js 
└── README.md
```
---

## Tier and Layer Explanation

### Presentation Tier
- อยู่ในโฟลเดอร์ `public`
- แสดงผล UI ให้ผู้ใช้งาน
- ติดต่อกับ API ผ่าน HTTP/HTTPS

---

### Application Tier (Node.js / Express)

#### Routes
- กำหนด REST API endpoints
- ส่ง request ไปยัง Controller

#### Controllers
- รับ request จาก Routes
- ตรวจสอบข้อมูลเบื้องต้น
- เรียกใช้งาน Service

#### Services (Business Logic)
- ประมวลผล Business Rules
- ไม่ผูกกับ HTTP หรือ Database

#### Repositories (Data Access)
- ติดต่อกับ PostgreSQL
- จัดการ SQL Queries
- แยกออกจาก Business Logic

---

### Data Tier
- PostgreSQL Database
- จัดเก็บข้อมูล Tasks
- Schema ถูกสร้างจาก `init.sql`

---

### Infrastructure Tier
- Nginx ทำหน้าที่:
  - Reverse Proxy
  - HTTPS / SSL Termination
  - Forward request ไปยัง API Server

---

## API Endpoints

| Method | Endpoint | Description |
|------|---------|------------|
| GET | /api/health | Health check |
| GET | /api/tasks | Get all tasks |
| POST | /api/tasks | Create task |
| PATCH | /api/tasks/:id/status | Update task status |

---

## Testing

ทดสอบ API โดยใช้ script

```bash
chmod +x scripts/*.sh #ให้สิทธิ์ไฟล์ .sh รันได้
./scripts/start-all.sh #สตาร์ททุกอย่างในระบบ 
./scripts/test-api.sh #ทดสอบ API ทั้งแบบตรง (localhost) และผ่าน Nginx เพื่อเช็กว่า endpoint ต่าง ๆ ใช้งานได้จริง
```
---

## Security
* ใช้ HTTPS ผ่าน Nginx

* Database แยกออกจาก Public Network

* Validation อยู่ใน Middleware Layer
---

## Conclusion
สถาปัตยกรรมแบบ N-Tier ช่วยให้ระบบมีโครงสร้างที่ชัดเจน
รองรับการขยายระบบในอนาคต และเหมาะสำหรับระบบระดับ Production

---

*ENGSE207 – Software Architecture* 
*มหาวิทยาลัยเทคโนโลยีราชมงคลล้านนา*
