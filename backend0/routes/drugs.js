const express = require('express');
const router = express.Router();
const obatController = require('../controllers/obatController');
// const { authenticateToken } = require('../middlewares/authMiddleware');

router.get('/', obatController.getAllObat);

module.exports = router;
