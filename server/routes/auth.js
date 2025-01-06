const express = require('express');
const { check, validationResult } = require('express-validator');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const asyncHandler = require('../utils/async_handler');
const auth_middleware = require('../middlewares/auth_middleware');
require('dotenv').config();

const authRouter = express.Router();
const saltRound = process.env.SALT_ROUND;
const jwtKey = process.env.JWT_KEY;

// Register a new user
authRouter.post("/api/signup", [
    check('email', 'Valid email is required').isEmail(),
    check('password', 'Password must be at least 6 characters long').isLength({ min: 6 }),
    check('name', 'Name is required').not().isEmpty()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const { email, password, name } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
        return res.status(400).json({ msg: "User with this email already exists" });
    }

    const salt = await bcrypt.genSalt(saltRound);
    const hashedPassword = await bcrypt.hash(password, salt);

    let user = new User({
        email,
        password: hashedPassword,
        name,
    });

    user = await user.save();
    res.json(user);
}));


// Sign in a user
authRouter.post("/api/signin", [
    check('email', 'Valid email is required').isEmail(),
    check('password', 'Password is required').not().isEmpty()
], asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
        return res.status(400).json({ msg: "Email does not exist" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
        return res.status(400).json({ msg: "Invalid credentials" });
    }

    const token = jwt.sign({ id: user._id }, jwtKey);
    res.json({ token, ...user._doc });
}));

// Check if token is valid
authRouter.post("/tokenIsValid", asyncHandler(async (req, res) => {
    const token = req.header('x-auth-token');
    if (!token) return res.json(false);

    const verified = jwt.verify(token, jwtKey);
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);

    res.json(true);
}));

// Get user data
authRouter.get("/", auth_middleware, asyncHandler(async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
}));

module.exports = authRouter;