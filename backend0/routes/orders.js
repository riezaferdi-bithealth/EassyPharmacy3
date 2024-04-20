const express = require('express');
const router = express.Router();

let orders = [];

router.get('/', (req, res) => {
    try {
        res.status(200).json(orders);
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

router.get('/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const order = orders.find(order => order.id === id);
    if (!order) {
        res.status(404).json({ error: 'Not Found' });
    } else {
        res.status(200).json(order);
    }
});
module.exports = router;
