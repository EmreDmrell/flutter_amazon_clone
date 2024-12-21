const express = require("express");
const { check, validationResult } = require('express-validator');
const productRouter = express.Router();
const auth_middleware = require("../middlewares/auth_middleware");
const { Product } = require("../models/product");
const asyncHandler = require('../utils/async_handler');

// Get products by category
productRouter.get("/api/products", auth_middleware, [
    check('category', 'Category is required').not().isEmpty()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const products = await Product.find({ category: req.query.category });
    res.json(products);
}));

// Search products by name
productRouter.get("/api/products/search/:name", auth_middleware, [
    check('name', 'Name is required').not().isEmpty()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const products = await Product.find({ name: { $regex: req.params.name, $options: "i" } });
    res.json(products);
}));

// Post request to rate the product
productRouter.post("/api/rate-product", auth_middleware, [
    check('id', 'Product ID is required').not().isEmpty(),
    check('rating', 'Rating is required').isInt({ min: 1, max: 5 })
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
        if (product.ratings[i].userId == req.user) {
            product.ratings.splice(i, 1);
        }
    }

    const ratingSchema = {
        userId: req.user,
        rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
}));

// Get request for deal-of-day
productRouter.get("/api/deal-of-day", auth_middleware, asyncHandler(async (req, res) => {
    let products = await Product.find({});

    products = products.sort((a, b) => {
        let aSum = 0;
        let bSum = 0;

        a.ratings.forEach((e) => {
            aSum += e.rating;
        });

        b.ratings.forEach((e) => {
            bSum += e.rating;
        });

        return bSum - aSum;
    });

    res.json(products[0]);
}));

module.exports = productRouter;