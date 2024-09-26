<template>
  <div class="container">
    <div class="form-container">
      <h1>เข้าสู่ระบบ</h1>
      <form @submit.prevent="" class="form-content">
        <div class="form-group">
          <label for="username">Username:</label>
          <input type="text" id="username" required class="form-input" />
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input type="password" id="lastName" required class="form-input" />
        </div>

        <button type="submit" class="form-button">เข้าสู่ระบบ</button>
      </form>
    </div>
  </div>
  <button class="btn btn-primary floating-button" @click="">Back</button>
</template>

<script></script>

<style scoped>
body {
  font-family: Arial, sans-serif;
  background-color: #f4f4f4;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.container {
  margin: 0 auto;
  display: flex;
  justify-content: center;
  align-content: center;
  padding-top: 50px;
}

.form-container {
  background-color: #fff;
  padding: 20px 40px;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  max-width: 400px;
  width: 100%;
}

h1 {
  font-size: 24px;
  margin-bottom: 20px;
  color: #333;
  text-align: center;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
  color: #555;
}

.form-input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 16px;
  box-sizing: border-box;
  transition: border-color 0.3s ease;
}

.form-input:focus {
  border-color: #007bff;
  outline: none;
}

.form-button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  font-size: 18px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.form-button:hover {
  background-color: #0056b3;
}
.floating-button {
  position: fixed;
  top: 1rem;
  right: 1rem;
  z-index: 1050;
}
</style>
