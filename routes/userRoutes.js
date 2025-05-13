const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const users = await prisma.user.findMany();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/:uid", async (req, res) => {
  const uid = parseInt(req.params.uid, 10);
  if (isNaN(uid)) {
    return res.status(400).json({ error: "uid ไม่ถูกต้อง" });
  }
  try {
    const user = await prisma.user.findUnique({
      where: { uid: uid },
      select: { uid: true, username: true, email: true, profile_image: true }
    });
    if (!user) {
      return res.status(404).json({ error: "ไม่พบผู้ใช้" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put("/update-profile", async (req, res) => {
  const { uid, profile_image } = req.body;
  
  if (!uid || !profile_image) {
    return res.status(400).json({ error: "ต้องระบุ uid และ profile_image" });
  }

  try {
    new URL(profile_image);
  } catch (e) {
    return res.status(400).json({ error: "URL รูปภาพไม่ถูกต้อง" });
  }

  try {
    const updatedUser = await prisma.user.update({
      where: { uid: uid },
      data: { profile_image },
      select: { uid: true, username: true, profile_image: true }
    });
    
    console.log(`อัปเดตโปรไฟล์ภาพสำเร็จสำหรับผู้ใช้ ${uid}`);
    res.json({
      success: true,
      uid: updatedUser.uid,
      username: updatedUser.username,
      profile_image: updatedUser.profile_image
    });
  } catch (error) {
    console.error('เกิดข้อผิดพลาดในการอัปเดตโปรไฟล์:', error);
    res.status(500).json({ 
      error: "ไม่สามารถอัปเดตโปรไฟล์ได้",
      details: error.message 
    });
  }
});

module.exports = router;