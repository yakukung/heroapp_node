require('dotenv').config();
const express = require("express");
const userRoutes = require('./routes/userRoutes');
const authRoutes = require('./routes/authRoutes');
const productRoutes = require('./routes/productRoutes');
const app = express();
const port = process.env.PORT || 3000;
const os = require("os");
let ip = "0.0.0.0";

Object.values(os.networkInterfaces()).forEach(iface => 
  iface.forEach(dev => { if (dev.family === "IPv4" && !dev.internal) ip = dev.address; })
);

app.get("/", (req, res) => res.send("Hello World!"));
app.use(express.json());
app.use("/users", userRoutes);
app.use("/auth", authRoutes);
app.use("/product", productRoutes);

const server = app.listen(port, () => console.log(`API listening at http://${ip}:${port}`));

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

process.on('SIGINT', async () => {
  try {
    await prisma.$disconnect();
    process.exit(0);
  } catch (error) {
    console.error('Error disconnecting Prisma:', error);
    process.exit(1);
  }
});

process.on('SIGTERM', async () => {
  try {
    await prisma.$disconnect();
    process.exit(0);
  } catch (error) {
    console.error('Error disconnecting Prisma:', error);
    process.exit(1);
  }
});