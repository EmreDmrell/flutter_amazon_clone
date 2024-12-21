const jwt = require('jsonwebtoken');
const cryptValues = require('../constants/hash_password_variables');
const User = require('../models/user');

const verifyToken = async (token) => {
    const verified = jwt.verify(token, cryptValues.jwtKey);
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