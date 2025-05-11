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
      where: { id: uid },
      select: { username: true, email: true }
    });
    if (!user) {
      return res.status(404).json({ error: "ไม่พบผู้ใช้" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;