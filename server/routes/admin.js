const express = require('express');
const adminRouter = express.Router();
const admin_middleware = require('../middlewares/admin_middleware');
const Product = require('../models/product.js');

adminRouter.post('/admin/add-product', admin_middleware, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category} = req.body; 

        let product = new Product(
            {
                name,
                description,
                images,
                quantity,
                price,
                category,
            }
        );

        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

module.exports = adminRouter;
