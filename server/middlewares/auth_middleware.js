const jwt = require('jsonwebtoken');
const cryptValues = require('../constants/hash_password_variables');
const jwtKey = cryptValues.jwtKey;

const auth_middleware = async (req, res, next) => {
    try {
        const token =  req.header('x-auth-token');
        if(!token)
            return res.status(401).json({msg : "There is no auth token. Access denied"});

        const verified = jwt.verify(token, jwtKey);
        if(!verified)
            return res.status(401).json({msg : "Token verification failed. Authorization denied"});

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({error : e.message});
    }
}

module.exports = auth_middleware;