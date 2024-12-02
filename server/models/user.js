const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true
    },
    email:{
        required: true,
        type: String,
        trim: true,
        validate: {
            validator : (val) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return val.match(re);
            },
            message: "Please enter a valid email adress",
        }
    },
    password:{
        required: true,
        type: String,
        validate: {
            validator : (val) => {
                return val.length > 7;
            },
            message: "Password lenght must be greater than 8 digit"
        }
    },
    address: {
        type: String,
        default: "",
      },
      type: {
        type: String,
        default: "user",
      },
      //card
});

const User = mongoose.model("User",userSchema);
module.exports = User;