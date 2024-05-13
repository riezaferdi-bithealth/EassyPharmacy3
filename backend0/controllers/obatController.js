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
        const formattedObats = obats.map(obat => ({
            id: obat.id,
            name: obat.name,
            description: obat.description,
            price: obat.price,
            stock: parseInt(obat.stock), // Mengonversi string ke integer
            image: obat.image
        }));

        const response = {
            status: true,
            message: "success",
            data: formattedObats
        };
        res.status(200).json(response);
    } catch (error) {
        console.error("Error in getAllObat:", error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
}



module.exports = {
    getAllObat
};