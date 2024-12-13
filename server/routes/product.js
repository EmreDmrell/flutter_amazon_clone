const express = require("express");
const productRouter = express.Router();
const auth_middleware = require("../middlewares/auth_middleware");
const {Product}  = require("../models/product");


productRouter.get("/api/products", auth_middleware, async (req, res) => {
    try {
        const products = await Product.find({category : req.query.category});
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

// get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name", auth_middleware, async (req, res) => {
    try {
        const products = await Product.find({name : { $regex: req.params.name, $options : "i"},});
        res.json(products)
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

// post request route to rate the product.

productRouter.post("/api/rate-product", auth_middleware, async (req, res) => {
    try {
        const { id, rating } = req.body;

        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++){
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i, 1);
            }
        }

        const ratingSchema = {
            userId: req.user,
            rating,
        }

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product); 
        
    } catch (e) {
        res.status(500).json({error : e.message})
    }
});

//get request for deal-of-day

productRouter.get("/api/deal-of-day", auth_middleware, async (req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;

            a.ratings.forEach((e) =>{
                aSum += e.rating;
            });

            b.ratings.forEach((e) =>{
                bSum += e.rating;
            });

            return aSum < bSum ? 1 : -1;
        });

        res.json(products[0]);
        

    } catch (e) {
        res.status(500).json({message : e.message})
    }
});

module.exports = productRouter