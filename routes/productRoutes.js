const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const products = await prisma.product.findMany({
      include: {
        author: {
          select: {
            username: true,
          },
        },
      },
    });

    const transformedProducts = products.map(product => ({
      ...product,
      author: product.author ? product.author.username : null,
    }));

    res.json(transformedProducts);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'เกิดข้อผิดพลาดในการดึงข้อมูลสินค้า' });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const product = await prisma.product.findUnique({
      where: { id: parseInt(req.params.id) },
      include: {
        author: {
          select: {
            username: true,
          },
        },
      },
    });
    if (!product) {
      return res.status(404).json({ error: 'ไม่พบสินค้านี้' });
    }

    // Transform the single product to flatten the author object
    const transformedProduct = {
      ...product,
      author: product.author ? product.author.username : null, // Extract username string
    };

    res.json(transformedProduct);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'เกิดข้อผิดพลาดในการดึงข้อมูลสินค้า' });
  }
});

module.exports = router;