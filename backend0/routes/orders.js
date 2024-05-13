const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

router.post('/checkout',orderController.checkoutOrder)
router.get('/history',orderController.getHistoryOrder)
router.post('/cart',orderController.postCartOrder)

module.exports = router;
