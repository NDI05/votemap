const db = require('../helper/connectionDB');
const handleDbError = require('../helper/dbErrorHandler');

exports.createUser = async (req, res) => {
    try {
        const actorIdUser = req.user.idUser;
        const { email, password, name, role, assignmentId } = req.body;
        if (!email || !password || !name || !role || assignmentId === undefined) {
            return res.status(400).json({ message: 'Semua field wajib diisi.' });
        }
        const query = 'CALL sp_users_create(?, ?, ?, ?, ?, ?)';
        await db.execute(query, [actorIdUser, email, password, name, role, assignmentId]);
        res.status(201).json({ message: 'Pengguna berhasil dibuat atau diaktifkan kembali.' });
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const actorIdUser = req.user.idUser;
        let searchQuery = null;
        let role = null;

        if( req.query.searchQuery != null){
            searchQuery = req.query.searchQuery;
        }
        if ( req.query.role != null){
            role = req.query.role;
        }

        const query = 'CALL sp_users_read_complex_00(?, ?, ?)';
        
        const [rows] = await db.execute(query, [
            actorIdUser,
            searchQuery,
            role || null
        ]);
        
        res.status(200).json(rows[0]);
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        console.log(handleDbError(error))
        return res.status(statusCode).json({ message });
    }
};

exports.updateUser = async (req, res) => {
    try {
        const actorIdUser = req.user.idUser;
        const targetIdUser = req.params.id;
        const { email, name, password, status } = req.body;
        const query = 'CALL sp_users_update(?, ?, ?, ?, ?, ?)';
        await db.execute(query, [actorIdUser, targetIdUser, email || null, name || null, password || null, status || null]);
        res.status(200).json({ message: 'Pengguna berhasil diperbarui.' });
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};

exports.deleteUser = async (req, res) => {
    try {
        const actorIdUser = req.user.idUser;
        const targetIdUser = req.params.id;
        const query = 'CALL sp_users_disable(?, ?)';
        await db.execute(query, [actorIdUser, targetIdUser]);
        res.status(204).send();
    } catch (error) {
        const { statusCode, message } = handleDbError(error);
        return res.status(statusCode).json({ message });
    }
};


// DELIMITER //

// DROP PROCEDURE IF EXISTS `sp_searchAdmin`;

// CREATE PROCEDURE `sp_searchAdmin`(
//     IN p_searchQuery VARCHAR(255),
//     IN p_userRole VARCHAR(50), -- Role pengguna yang melakukan pencarian
//     IN p_idProvince BIGINT,    -- ID provinsi pengguna
//     IN p_idCity BIGINT,        -- ID kota pengguna
//     IN p_idDistrict BIGINT,    -- ID distrik pengguna
//     IN p_idSubDistrict BIGINT, -- ID sub-distrik pengguna
//     IN p_idTps BIGINT 
// )
// BEGIN
//     SELECT 
//         idUser,
//         email ,
//         name ,
//         role ,
//         provinceName,
//         cityName,
//         districtName,
//         subDistrictName,
//         tpsName
//     FROM vw_admin_users
//     WHERE 
//         (
//             -- Filter berdasarkan yurisdiksi
//             (p_userRole = 'national') OR
//             (p_userRole = 'province' AND idProvince = p_idProvince) OR
//             (p_userRole = 'city' AND idCity = p_idCity) OR
//             (p_userRole = 'district' AND idDistrict = p_idDistrict) OR
//             (p_userRole = 'sub_district' AND idSubDistrict = p_idSubDistrict) OR 
//             (p_userRole = 'adminTps' AND idTps = p_idTps)
//         )
//         AND (
//             -- Filter berdasarkan kata kunci pencarian
//             name LIKE CONCAT('%', p_searchQuery, '%') OR
//             email LIKE CONCAT('%', p_searchQuery, '%') OR
//             provinceName LIKE CONCAT('%', p_searchQuery, '%') OR
//             cityName LIKE CONCAT('%', p_searchQuery, '%') OR
//             districtName LIKE CONCAT('%', p_searchQuery, '%') OR
//             subDistrictName LIKE CONCAT('%', p_searchQuery, '%') OR
//             tpsName LIKE CONCAT('%', p_searchQuery, '%')
//         );
// END //
// DELIMITER ;

