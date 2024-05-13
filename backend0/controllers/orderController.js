const { PemesananObat } = require('../models');
const {Obat} = require('../models');
const { User } = require('../models');

const checkoutOrder = async(req,res) => {
    try{
        const { id_struct,id_user, list_medicines } = req.body;

        const user = await User.findOne({ where: { id:id_user } });
        console.log("user>>>>",user);
        if (!user){
            throw{name:"InvalidData"}
        }
        for (el of list_medicines){
            const idObat= await Obat.findOne({where:{id:el.id} });
            console.log("idOBAT>>>",idObat,"obatnya>>", el.id);
            if (!idObat) throw{name:"Datanotfound"}
            if (el.qty>idObat.stock) throw{name:"InvalidStock"}
        }
        console.log("INIIIII>>>",list_medicines);
        await PemesananObat.create({
            id: id_struct, // id_struct dari body
            id_user: id_user, // id_user dari body
            list_medicines: JSON.parse(JSON.stringify(list_medicines)) // list_medicines dari body
        });
        let result = {
            status:true,
            message:"success",
            data:list_medicines
        }
        res.status(201).json(result);
        } catch (error){
        console.error(error);
        if (error.name=="InvalidData"){
            res.status(401).json({message:'Invalid id'})
        }else if(error.name=="InvalidStock"){
            res.status(400).json({message:'not enough stock'})
        }else if (error.name=="Datanotfound"){
            res.status(404).json({message:'id obat not found'})
        }else {
            res.status(500).json({ message: 'Internal Server Error' });
        }
            
    }
    
};
const getHistoryOrder = async (req, res) => {
    try {
        const { id_user, list_medicines } = req.body;
        const user = await PemesananObat.findOne({ where: { id_user } });
        if (!user){
            throw{name:"InvalidData"}
        }
        for (el of list_medicines){
            
            const idObat= await Obat.findOne({where:{id:el.id} });
            if (!idObat) {throw{name:"Data not found"}}
        }
        // console.log(list_medicines);
        let result = {
            status:true,
            message:"success",
            data:list_medicines
        }
        res.status(200).json(result);
    } catch (error) {
        console.error(error);
        if (error.name=="InvalidData"){
            res.status(401).json({message:'User not found'})
        }else{
            res.status(500).json({ message: 'Internal Server Error' });
        }
    }
};
const postCartOrder = async(req,res) => {
    try{
        const { id_user, list_medicines } = req.body;
        const user = await PemesananObat.findOne({ where: { id_user } });
        if (!user){
            throw{name:"InvalidData"}
        }
        for (el of list_medicines){
            const idObat= await Obat.findOne({where:{id:el.id} });
            if (!idObat) throw{name:"Data not found"}
            if (el.qty>idObat.stock) throw{name:"stockEmpty"}
        }
        // console.log(list_medicines);
        let result = {
            status:true,
            message:"success",
            data:list_medicines
        }
        res.status(201).json(result);
        } catch (error){
        console.error(error);
        if (error.name=="InvalidData"){
            res.status(401).json({message:'User not found'})
        }else if (error.name=="Data not found"){
            res.status(404).json({message:'id obat not found'})
        }else {
            res.status(500).json({ message: 'Internal Server Error' });
        }
            
    }
    
};
module.exports = {
    checkoutOrder,
    getHistoryOrder,
    postCartOrder
};