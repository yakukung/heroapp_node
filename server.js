const express = require("express");
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const app = express();
const port = 3000; 

var os = require("os");
var ip = "0.0.0.0"; 
var ips = os.networkInterfaces();

app.get("/", (req, res) => {
    res.send("Hello World!");
});

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
        // ลอง query อะไรง่าย ๆ จากตาราง User
        await prisma.user.findFirst();
        res.json({ status: "ok", message: "เชื่อมต่อฐานข้อมูลสำเร็จ" });
    } catch (error) {
        res.status(500).json({ status: "error", message: "เชื่อมต่อฐานข้อมูลไม่สำเร็จ", error: error.message });
    }
});

Object.keys(ips).forEach(function (_interface) {
  ips[_interface].forEach(function (_dev) {
    if (_dev.family === "IPv4" && !_dev.internal) {
      ip = _dev.address;
    }
  });
});

app.listen(port, () => {
  console.log(`API listening at http://${ip}:${port}`);
});

process.on('SIGINT', async () => {
  await prisma.$disconnect();
  process.exit(0);
});