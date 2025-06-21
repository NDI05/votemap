const express = require('express');
const router = express.Router();
const getRegion = require('../controllers/getRegion');

router.get('/province', getRegion.getProvince);
router.get('/city', getRegion.getCity);
router.get('/district', getRegion.getDistrict);
router.get('/subdistrict', getRegion.getSubDistrict);
router.get('/tps', getRegion.gettps);

module.exports = router;