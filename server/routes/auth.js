const express = require('express');
const User = require("../models/user");
const cryptValues = require("../constants/hash_password_variables");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const auth_middleware = require("../middlewares/auth_middleware");

const authRouter = express.Router();
const saltRound = cryptValues.saltRounds;

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {name, email, password} = req.body;
    
        const existingUser = await User.findOne({ email });
        if(existingUser){
            return res.status(400).json({msg : "User with same e-mail adress already exists"});
        }

        const salt = await bcrypt.genSalt(saltRound);
        const hashedPassword = await bcrypt.hash(password, salt);


        let user = new User({
            email,
            password : hashedPassword,
            name,
        });

        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

authRouter.post("/api/signin", async (req, res) => {
    try {
        const {email, password} = req.body;

        const user = await User.findOne({ email });

        if(!user){
            return res.status(400)
            .json({msg : "E mail does not exist "});
        }


        const isMatch = await bcrypt.compare(password, user.password );

        if(!isMatch){
            return res.status(400).json({msg : "Wrong password"});
        }

        const token = jwt.sign({id : user._id}, cryptValues.jwtKey);
        res.json({token, ...user._doc});
        // token, ...user._doc =  User(
        // token, id, name , email, ... ) Basicly means it send token within User object
        //


    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header('x-auth*token');
        if(!token) return res.json(false);
        const verified = jwt.verify(token, cryptValues.jwtKey);
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if(!user) return json(false);

        res.json(true);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});


// get user data
authRouter.get("/", auth_middleware, async (req, res) => {
    try {
        const user = await User.findById(req.user);
        res.json({ ...user._doc, token : req.token});
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});
module.exports = authRouter;