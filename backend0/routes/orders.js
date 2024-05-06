const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

router.get('/tes', orderController.getAllOrders);
router.post('/checkout',orderController.checkoutOrder)
router.get('/history',orderController.getHistoryOrder)
router.post('/cart',orderController.postCartOrder)
router.get('/:id', orderController.getOrderById);

module.exports = router;
