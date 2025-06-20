require('dotenv').config();
const express = require('express')
const app = express();
const application = require ('./routes/index');
const cors = require('cors')

const port = process.env.PORT;

app.use(cors({
    origin: '*',
    methods: ['GET','POST','PUT','DELETE'],
    allowedHeaders: ['Content-Type','Authorization']
}));

app.use(express.urlencoded({extended : true}))
app.use(express.json());

app.use('/',application);

const path = require('path')



app.listen(port, () => {
    console.log(`server listening on port ${port}`)
})
