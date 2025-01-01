const jwt = require('jsonwebtoken');
const User = require('../models/user');
require('dotenv').config();
const jwtKey = process.env.JWT_KEY;

const verifyToken = async (token) => {
    const verified = jwt.verify(token, jwtKey);
    if (!verified) {
        throw new Error("Token verification failed. Authorization denied");
    }
    const user = await User.findById(verified.id);
    if (!user) {
        throw new Error("User not found");
    }
    return { user, verified };
};

module.exports = { verifyToken };