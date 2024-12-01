const jwt = require('jsonwebtoken');
const cryptValues = require('../constants/hash_password_variables');
const jwtKey = cryptValues.jwtKey;
const User = require('../models/user');

const admin_middleware = async (req, res, next) => {
    try {
        const token  =req.header('x-auth-token');
        
        if(!token)
            return res.status(401).json({msg : "There is no auth token. Access denied"});

        const verified = jwt.verify(token, jwtKey);
        if(!verified)
            return res.status(401).json({msg : "Token verification failed. Authorization denied"});

        const user = await User.findById(verified.id);
        if(user.type != 'admin')
            return res.status(401).json({msg : 'You have no permission to accss'});

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({error : e.message});
    }
}

module.exports = admin_middleware;