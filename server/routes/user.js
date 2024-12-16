const express = require('express');
const userRouter = express.Router();
const auth_middleware = require('../middlewares/auth_middleware');
const {Product} = require('../models/product.js');
const User = require('../models/user.js');

//add product
userRouter.post('/api/add-to-cart', auth_middleware, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if (user.cart.length == 0){
            user.cart.push({product, quantity : 1});
        }else{
            let isProductFound = false;
            for(let i = 0; i < user.cart.length ; i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound = true;
                }
            }

            if(isProductFound){
                let productToIncrease = user.cart.find(
                    (e) => 
                        e.product._id.equals(product._id)
                );
                productToIncrease.quantity +=1;
            }else{
                user.cart.push({product, quantity : 1})
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

//remove product from cart
userRouter.delete('/api/remove-from-cart/:id', auth_middleware, async (req, res) => {
    try {
        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for(let i = 0; i < user.cart.length ; i++){
            if(user.cart[i].product._id.equals(product._id)){
                if(user.cart[i].quantity ==1) {
                    user.cart.splice(i, 1);
                }else{
                    user.cart[i].quantity -= 1;
                }
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});
module.exports = userRouter