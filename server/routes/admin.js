const express = require('express');
const adminRouter = express.Router();
const admin_middleware = require('../middlewares/admin_middleware');
const {Product} = require('../models/product.js');

//add product
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

//get all product

adminRouter.get('/admin/get-products', admin_middleware, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products)
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

// delete product 

adminRouter.delete('/admin/delete-product', admin_middleware , async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product); 
    } catch (e) {
        res.status(500).json({msg : e.message});
    }
});



module.exports = adminRouter;
