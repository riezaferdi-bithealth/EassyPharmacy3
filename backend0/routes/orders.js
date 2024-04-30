const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

router.get('/tes', orderController.getAllOrders);
router.get('/:id', orderController.getOrderById);
router.post('/checkout',orderController.checkoutOrder)

module.exports = router;
