const { verifyToken } = require('../utils/jwt');

const admin_middleware = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.status(401).json({ msg: "There is no auth token. Access denied" });

        const { user, verified } = await verifyToken(token);
        if (user.type !== 'admin') return res.status(401).json({ msg: 'You have no permission to access' });

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = admin_middleware;