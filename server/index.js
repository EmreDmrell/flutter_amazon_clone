//Import packages
const express = require('express');
const mongoose = require('mongoose');


//Import from other files 

const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const mongoDbUri = require('./constants/database_variables');


//INIT

const PORT = 3000;
const app = express();
const DB = mongoDbUri;

//middleware 

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

//connections

mongoose
.connect(DB)
.then(() => {
    console.log("connection to database is successfull")
})
.catch((e) => {
    console.log(e)
});

app.listen(PORT, '0.0.0.0', () => {console.log(`Connected at ${PORT}`)})
