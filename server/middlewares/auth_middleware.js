const { verifyToken } = require('../utils/jwt');

const auth_middleware = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.status(401).json({ msg: "There is no auth token. Access denied" });

        const { verified } = await verifyToken(token);
        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = auth_middleware;