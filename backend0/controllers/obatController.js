const {Obat} = require('../models');
const { Op } = require('sequelize')

// Fungsi untuk mendapatkan semua obat
// handle pagination di getAllObat
const getAllObat = async (req, res) => {
    let {search,page} = req.query
    try {
        let options = {}
        let limit
        let offset
        if (search){
            options = {
                where: { "name": { [Op.iLike]: '%'+search +'%'} }
                }
        }
        if(page !== '' && typeof page!=='undefined'){
            if(page.size !==''  && typeof page.size!=='undefined'){
                limit  = page.size
                options.limit = limit
            }
            if(page.number !==''  && typeof page.number!=='undefined'){
                offset = page.number*limit - limit
                options.offset= offset
            }
        }else{
            limit = 5;
            offset = 0
            options.limit = limit
            options.offset = offset
        }
        const obats = await Obat.findAll(options);
        res.status(200).json(obats);
    } catch (error) {
        console.log(error)
        res.status(500).json({ message: 'Internal Server Error' });
    }
}

const getObatById = async (req, res) => {
    const id = req.params.id;
    try {
        const obat = await Obat.findByPk(id);
        if (!obat) {
            res.status(404).json({ error: 'Not Found' });
        } else {
            res.status(200).json(obat);
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error' });
    }
}


module.exports = {
    getAllObat,
    getObatById
};