const express = require('express');
const User = require("../models/user");
const cryptValues = require("../constants/hash_password_variables");
const bcrypt = require("bcrypt");

const authRouter = express.Router()
const saltRound = cryptValues.saltRounds;

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {name, email, password} = req.body
    
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
        res.json(user)
    } catch (e) {
        res.status(500).json({error: e.message})
    }
});

module.exports = authRouter;