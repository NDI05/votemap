require('dotenv').config();

const express = require('express');
const cors = require('cors');
const application = require('./route/index');

const app = express();
const port = process.env.PORT || 3000;


const corsOptions = {
    origin: '*',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE','OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    };

app.use("/upload", express.static("uploads"))
app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/', application);

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
