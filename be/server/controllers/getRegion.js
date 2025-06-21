const db = require('../helper/connectionDB');
const handleDbError = require('../helper/dbErrorHandler');

exports.getProvince = async (req, res) => {
    try {
        const query = 'SELECT idProvince, name FROM provinceData';
        const [rows] = await db.execute(query);
        res.status(200).json(rows);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.getCity = async (req, res) => {
    try {
        const {idprovince} = req.query
        const query = 'SELECT idCity, name FROM cityData WHERE idProvince = ?';
        const [rows] = await db.execute(query, [idprovince]);
        res.status(200).json(rows);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.getDistrict = async (req, res) => {
    try {
        const {idcity} = req.query
        const query = 'SELECT idDistrict, name FROM districtData WHERE idCity = ?';
        const [rows] = await db.execute(query, [idcity]);
        res.status(200).json(rows);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.getSubDistrict = async (req, res) => {
    try {
        const {iddistrict} = req.query
        const query = 'SELECT idSubDistrict, name FROM subDistrictData WHERE idDistrict = ?';
        const [rows] = await db.execute(query, [iddistrict]);
        res.status(200).json(rows);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.gettps = async (req, res) => {
    try {
        const {idsubdistrict, iddistrict} = req.query
        //
        const query = 'SELECT idTps, name FROM tpsdata WHERE idSubDistrict = (SELECT idSubDistrict FROM subDistrictData WHERE name = ? AND idDistrict = ?)';
        const [rows] = await db.execute(query, [idsubdistrict, iddistrict]);
        console.log(rows);
        res.status(200).json(rows);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};
