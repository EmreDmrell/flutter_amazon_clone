const express = require("express");
const productRouter = express.Router();
const auth_middleware = require("../middlewares/auth_middleware");
const Product = require("../models/product");


productRouter.get("/api/products", auth_middleware, async (req, res) => {
    try {
        const products = await Product.find({category : req.query.category});
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

// create a get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name", auth_middleware, async (req, res) => {
    try {
        const product = await Product.find({name : { $regex: req.params.name, $option : "i"},});
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

module.exports = productRouter