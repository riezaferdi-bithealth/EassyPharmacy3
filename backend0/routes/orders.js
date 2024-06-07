const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

router.post('/checkout',orderController.checkoutOrder)
router.get('/history',orderController.getHistoryOrder)
router.post('/cart',orderController.postCartOrder)
router.delete('/cart/item/:id_user/:list_medicines', orderController.deleteCartItem);

module.exports = router;
