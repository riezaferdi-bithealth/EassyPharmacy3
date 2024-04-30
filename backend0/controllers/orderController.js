const { PemesananObat } = require('../models');
const { User } = require('../models');
const {Obat} = require('../models');
const getAllOrders = async (req, res) => {
    try {
        console.log(req.query)
        const orders = await PemesananObat.findAll();
        res.status(200).json(orders);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

const getOrderById = async (req, res) => {
    const id = parseInt(req.params.id);
    try {
        const order = await PemesananObat.findByPk(id);
        if (!order) {
            res.status(404).json({ error: 'Not Found' });
        } else {
            res.status(200).json(order);
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};
const checkoutOrder = async(req,res) => {
    try{
        const { id_user, list_medicines } = req.body;
        const user = await User.findOne({ where: { id:id_user } });
        if (!user){
            throw{name:"InvalidData"}
        }
        for (el of list_medicines){
            const idObat= await Obat.findOne({where:{id:el.id} });
            if (!idObat) throw{name:"Data not found"}
            if (el.qty>idObat.stock) throw{name:""}
        }
        console.log(list_medicines);
        let result = {
            status:true,
            message:"success",
            data:list_medicines
        }
        res.status(201).json(result);
        } catch (error){
        console.error(error);
        if (error.name="InvalidData"){
            res.status(401).json({message:'User not found'})
        }else if (error.name="Data not found"){
            res.status(404).json({message:'id obat not found'})
        }else {
            res.status(500).json({ message: 'Internal Server Error' });
        }
            
    }
    
}

module.exports = {
    getAllOrders,
    getOrderById,
    checkoutOrder
};