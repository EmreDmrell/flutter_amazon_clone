const express = require('express');
const { check, validationResult, param } = require('express-validator');
const adminRouter = express.Router();
const admin_middleware = require('../middlewares/admin_middleware');
const { Product } = require('../models/product');
const asyncHandler = require('../utils/async_handler');
const Order  = require('../models/order');

// Add product
adminRouter.post('/admin/add-product', admin_middleware, [
    check('name', 'Name is required').not().isEmpty(),
    check('description', 'Description is required').not().isEmpty(),
    check('images', 'Images are required').isArray({ min: 1 }),
    check('quantity', 'Quantity is required').isInt({ gt: 0 }),
    check('price', 'Price is required').isFloat({ gt: 0 }),
    check('category', 'Category is required').not().isEmpty()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const { name, description, images, quantity, price, category } = req.body;

    let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
    });

    product = await product.save();
    res.json(product);
}));

// Get all products
adminRouter.get('/admin/get-products', admin_middleware, asyncHandler(async (req, res) => {
    const products = await Product.find({});
    res.json(products);
}));

// Delete product
adminRouter.delete('/admin/delete-product/:id', admin_middleware, [
    param('id', 'Invalid product ID').isMongoId()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }
    const { id } = req.params;
    const product = await Product.findByIdAndDelete(id);
    res.json(product);
}));

// Get all orders

adminRouter.get('/admin/get-orders', admin_middleware, asyncHandler(async (req, res) => {
    const orders = await Order.find({});
    res.json(orders);
}));

// Update order status

adminRouter.put('/admin/update-order-status/:id', admin_middleware, [   
    param('id', 'Invalid order ID').isMongoId(),
    check('status', 'Status is required').isInt({ min: 0, max: 3 }),
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }
    const { id } = req.params;
    const { status } = req.body;
    const order = await Order.findByIdAndUpdate(id, { status }, { new: true });
    res.json(order);
}));
module.exports = adminRouter;
