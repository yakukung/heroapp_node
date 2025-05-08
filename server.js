require('dotenv').config();
const express = require("express");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient({
  datasources: { db: { url: process.env.DATABASE_URL } },
  log: ['error']
});
const app = express();
const port = 3000;
const os = require("os");
let ip = "0.0.0.0";

// ตรวจหา IP address
Object.values(os.networkInterfaces()).forEach(iface => 
  iface.forEach(dev => { if (dev.family === "IPv4" && !dev.internal) ip = dev.address; })
);

app.get("/", (req, res) => res.send("Hello World!"));

app.get("/users", async (req, res) => {
  try {
    const users = await prisma.user.findMany();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get("/db-check", async (req, res) => {
  try {
    await prisma.user.findFirst();
    res.json({ status: "ok", message: "เชื่อมต่อฐานข้อมูลสำเร็จ" });
  } catch (error) {
    res.status(500).json({ status: "error", message: "เชื่อมต่อฐานข้อมูลไม่สำเร็จ", error: error.message });
  }
});

const server = app.listen(port, () => console.log(`API listening at http://${ip}:${port}`));

// Graceful shutdown
async function closeApp() {
  server.close();
  await prisma.$disconnect();
  process.exit(0);
}

process.on('SIGINT', closeApp);
process.on('SIGTERM', closeApp);