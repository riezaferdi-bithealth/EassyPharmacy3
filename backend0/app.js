const express = require('express');
const dotenv = require('dotenv').config();
const bodyParser = require('body-parser');
const drugRoutes = require('./routes/drugs');
const orderRoutes = require('./routes/orders');
const userRoutes = require('./routes/userRoutes')

const app = express();
app.use(bodyParser.json());

app.use('/user', userRoutes);
app.use('/drug',drugRoutes);
app.use('/orders',orderRoutes);

const PORT = process.env.PORT || 3000;
if (process.env.NODE_ENV !== 'test') {
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}`);
    });
}
// app.listen(PORT, () => {
//     console.log(`Server is running on port ${PORT}`);
// });

module.exports = app