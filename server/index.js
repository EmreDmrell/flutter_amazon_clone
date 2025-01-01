//Import packages
const express = require('express');
const mongoose = require('mongoose');
const errorHandler = require('./middlewares/error_handler');
require('dotenv').config();


//Import from other files 

const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');


//INIT

const PORT = process.env.PORT || 3000;
const app = express();
const MONGO_DB_URI = process.env.MONGO_DB_URI;

//middleware 

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//error handling middleware
app.use(errorHandler);

//connections

mongoose
.connect(MONGO_DB_URI)
.then(() => {
    console.log("connection to database is successful")
})
.catch((e) => {
    console.log(`Failed to connect to the database: ${e.message}`)
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Connected at ${PORT}`);
});
