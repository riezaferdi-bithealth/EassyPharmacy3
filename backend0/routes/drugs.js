const express = require('express');
const router = express.Router();
const obatController = require('../controllers/obatController');
const { authenticateToken } = require('../middlewares/authMiddleware');
// let drugs = [
//     { id: 1, name: 'sanmol', price: 5000 },
//     { id: 2, name: 'betadin', price: 10000 },
//     { id: 3, name: 'komix', price: 7000 }
// ];

router.get('/', (req, res) => {
    try {
        res.status(200).json(drugs);
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

router.get('/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const drug = drugs.find(drug => drug.id === id);
    if (!drug) {
        res.status(404).json({ error: 'Not Found' });
    } else {
        res.status(200).json(drug);
    }
});

module.exports = router;
