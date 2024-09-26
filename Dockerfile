# ใช้ภาพ (image) Node.js เวอร์ชั่นล่าสุดบน Alpine เป็นพื้นฐาน
FROM node:18-alpine

# ตั้งค่าไดเร็กทอรี่ทำงานภายใน container
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์ทั้งหมดไปยัง working directory
COPY . .

# เปิดพอร์ตที่ Vue.js จะรัน (ตามที่กำหนดใน vite.config.js เป็นพอร์ต 3030)
EXPOSE 3030

# รันคำสั่งเพื่อพัฒนาแอป
CMD ["npm", "run", "dev"]
