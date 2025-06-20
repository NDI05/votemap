const express = require('express');
const router = express.Router();
const adminController = require('../controller/adminController');
const { authenticateToken } = require('../middleware/authMiddleware')


router.get('/',authenticateToken, adminController.getAllUsers);
router.post('/',authenticateToken, adminController.createAdmin);
router.put('/:id',authenticateToken, adminController.updateUser);
router.delete('/:id',authenticateToken, adminController.deleteUser);

module.exports = router;