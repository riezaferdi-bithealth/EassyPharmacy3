const express = require('express');
const router = express.Router();
const obatController = require('../controllers/obatController');
// const { authenticateToken } = require('../middlewares/authMiddleware');

router.get('/', obatController.getAllObat);
router.get('/:id', obatController.getObatById);

module.exports = router;
