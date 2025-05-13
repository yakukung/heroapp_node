const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const SALT_ROUNDS = 12;

// ล็อคอิน
router.post("/login", async (req, res) => {
  const { usernameOrEmail, password } = req.body;

  if (!usernameOrEmail || !password) {
    return res.status(400).json({ 
      error: 'กรุณากรอกข้อมูลให้ครบถ้วน'
    });
  }

  try {
    const whereCondition = isEmail(usernameOrEmail) 
      ? { email: usernameOrEmail }
      : { username: usernameOrEmail };

    const user = await prisma.user.findFirst({
      where: whereCondition
    });

    if (!user) {
      return res.status(401).json({ 
        error: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'
      });
    }

    // ตรวจสอบความยาวรหัสผ่านที่ผู้ใช้กรอก (ไม่ใช่ hash)
    const passwordValidation = validatePassword(password);
    if (!passwordValidation.valid) {
      return res.status(400).json({ 
        error: passwordValidation.message
      });
    }

    // ตรวจสอบรหัสผ่านกับ hash ในฐานข้อมูล
    const passwordValid = await bcrypt.compare(password, user.password);
    if (!passwordValid) {
      return res.status(401).json({ 
        error: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'
      });
    }

    const token = jwt.sign(
      {
        userId: user.id,
        username: user.username,
        iat: Math.floor(Date.now() / 1000)
      },
      process.env.JWT_SECRET,
      { 
        expiresIn: '1h',
        algorithm: 'HS256'
      }
    );

    res.json({ 
      status: "ok",
      token: token,
      uid: user.uid,
      username: user.username,
      message: "เข้าสู่ระบบสำเร็จ"
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ 
      error: `เกิดข้อผิดพลาดในการเชื่อมต่อ: ${error.message}`
    });
  }router.post("/register", async (req, res) => {
    const { username, email, password } = req.body;
  
    // เช็คข้อมูลครบถ้วน
    if (!username || !email || !password) {
      return res.status(400).json({ error: "กรุณากรอกข้อมูลให้ครบถ้วน" });
    }
  
    // เช็ครูปแบบอีเมล
    if (!isEmail(email)) {
      return res.status(400).json({ error: "รูปแบบอีเมลไม่ถูกต้อง" });
    }
  
    // เช็คความยาวรหัสผ่าน
    if (password.length < 8) {
      return res.status(400).json({ error: "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร" });
    }
  
    // เช็ค username ซ้ำ
    const existUsername = await prisma.user.findUnique({ where: { username } });
    if (existUsername) {
      return res.status(400).json({ error: "username นี้ถูกใช้ไปแล้ว" });
    }
  
    // เช็ค email ซ้ำ
    const existEmail = await prisma.user.findUnique({ where: { email } });
    if (existEmail) {
      return res.status(400).json({ error: "email นี้ถูกใช้ไปแล้ว" });
    }
  
    // เช็ค password ตามเงื่อนไขเพิ่มเติม (ถ้ามี)
    const passwordValidation = validatePassword(password);
    if (!passwordValidation.valid) {
      return res.status(400).json({ error: passwordValidation.message });
    }
  
    try {
      // เข้ารหัสรหัสผ่านก่อนบันทึก
      const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);
      const user = await prisma.user.create({
        data: {
          username,
          email,
          password: hashedPassword
        }
      });
      res.json({ status: "ok", userId: user.id, username: user.username });
    } catch (error) {
      res.status(500).json({ error: `เกิดข้อผิดพลาด: ${error.message}` });
    }
  });
});

router.post("/register", async (req, res) => {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({ error: "กรุณากรอกข้อมูลให้ครบถ้วน" });
  }

  if (!isEmail(email)) {
    return res.status(400).json({ error: "รูปแบบอีเมลไม่ถูกต้อง" });
  }

  if (password.length < 8) {
    return res.status(400).json({ error: "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร" });
  }

  const existUsername = await prisma.user.findUnique({ where: { username } });
  if (existUsername) {
    return res.status(400).json({ error: "username นี้ถูกใช้ไปแล้ว" });
  }

  const existEmail = await prisma.user.findUnique({ where: { email } });
  if (existEmail) {
    return res.status(400).json({ error: "email นี้ถูกใช้ไปแล้ว" });
  }

  const passwordValidation = validatePassword(password);
  if (!passwordValidation.valid) {
    return res.status(400).json({ error: passwordValidation.message });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);
    const user = await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword
      }
    });
    res.json({ status: "ok", userId: user.id, username: user.username });
  } catch (error) {
    res.status(500).json({ error: `เกิดข้อผิดพลาด: ${error.message}` });
  }
});

function isEmail(input) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(input);
}

function validatePassword(password) {
  if (password.length < 8) {
    return { valid: false, message: 'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร' };
  }
  return { valid: true };
}

module.exports = router;