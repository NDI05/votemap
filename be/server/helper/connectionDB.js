const mysql = require('mysql2');

const db = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
}).promise();

const test = async () => {
    try {
        const conn = await db.getConnection();
        console.log('Koneksi ke Database Berhasil');
        conn.release();
    } catch (error) {
        console.error('Koneksi ke Database gagal : ',error);
    }
}

test();

module.exports = db;
