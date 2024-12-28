const express = require("express");
const { check, validationResult } = require("express-validator");
const userRouter = express.Router();
const auth_middleware = require("../middlewares/auth_middleware");
const { Product } = require("../models/product.js");
const User = require("../models/user.js");
const Order = require("../models/order.js");
const { findProductInCart } = require("../utils/cart");
const asyncHandler = require("../utils/async_handler");

// Add product to cart
userRouter.post(
  "/api/add-to-cart",
  [auth_middleware, check("id", "Product ID is required").not().isEmpty()],
  asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    let cartItem = findProductInCart(user.cart, product._id);
    if (cartItem) {
      cartItem.quantity += 1;
    } else {
      user.cart.push({ product, quantity: 1 });
    }

    user = await user.save();
    res.json(user);
  })
);

// Remove product from cart
userRouter.delete(
  "/api/remove-from-cart/:id",
  [auth_middleware, check("id", "Product ID is required").not().isEmpty()],
  asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    let cartItem = findProductInCart(user.cart, product._id);
    if (cartItem) {
      if (cartItem.quantity === 1) {
        user.cart = user.cart.filter(
          (item) => !item.product._id.equals(product._id)
        );
      } else {
        cartItem.quantity -= 1;
      }
    }

    user = await user.save();
    res.json(user);
  })
);

// Save user address
userRouter.post(
  "/api/save-user-address",
  [auth_middleware, check("address", "Address is required").not().isEmpty()],
  asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  })
);

// Order products
userRouter.post(
  "/api/order",
  [
    auth_middleware,
  ],
  asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        product = await product.save();
        products.push({
          product,
          quantity: cart[i].quantity,
        });
      } else {
        return res
          .status(400)
          .json({ errors: [{ msg: `${product.name} is out of stoc` }] });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });

    order = await order.save();
    res.json(order);
  })
);

// Get my orders

userRouter.get('/api/orders/me', auth_middleware, asyncHandler(async (req, res) => {
  const orders = await Order.find({ userId: req.user });
  res.json(orders);
}));

module.exports = userRouter;
