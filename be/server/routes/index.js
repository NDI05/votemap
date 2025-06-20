const router = require('express').Router();
const authRoutes = require('./authRoutes');
const adminRoutes = require('./adminRoutes');
// const tpsRoutes = require('./tpsRoutes');
// const laporanRoutes = require('./laporanRoutes');
// const voterRoutes = require('./voterRoutes');
// const attendanceRoutes = require('./attendanceRoutes');

router.use('/auth',authRoutes);
router.use('/admin',adminRoutes);
// router.use('tps',tpsRoutes);
// router.use('/laporan',laporanRoutes);
// router.use('/voter',voterRoutes);
// router.use('/attendance',attendanceRoutes);

module.exports = router;
