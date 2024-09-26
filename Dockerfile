# ใช้ภาพ (image) Node.js เวอร์ชั่นล่าสุดบน Alpine เป็นพื้นฐาน
FROM node:18-alpine

# ตั้งค่าไดเร็กทอรี่ทำงานภายใน container
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json
COPY package*.json ./

# ติดตั้ง dependencies ด้วยตัวเลือก --unsafe-perm
RUN npm install --unsafe-perm

# คัดลอกไฟล์ทั้งหมดไปยัง working directory
COPY . .

# เปิดพอร์ตที่ Vue.js จะรัน (พอร์ต 3030)
EXPOSE 3030

# รันคำสั่งเพื่อพัฒนาแอป
CMD ["npm", "run", "dev"]
