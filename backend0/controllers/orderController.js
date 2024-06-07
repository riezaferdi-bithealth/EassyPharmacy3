require('dotenv').config();
const { PemesananObat } = require('../models');
const {Obat} = require('../models');
const { User, Cart } = require('../models');
const jwt = require('jsonwebtoken');

const checkoutOrder = async(req,res) => {
    try{
        const { id_user, list_medicines } = req.body;
        // console.log("REQ BODY=>>>",req.body);
        const user = await User.findOne({ where: { id:id_user } });
        // console.log("user>>>>",user);
        if (!user){
            throw{name:"InvalidData"}
        }
        const updatedList = [];
        for (el of list_medicines){
            const idObat= await Obat.findOne({where:{id:el.id} });
            // console.log("idOBAT>>>",idObat,"obatnya>>", el.id);
            if (!idObat) throw{name:"Datanotfound"}
            if (el.qty>idObat.stock) throw{name:"InvalidStock"}
            // Kurangi stok obat
            await Obat.update({ stock: idObat.stock - el.qty }, { where: { id: idObat.id } });
            const updatedMedicine = {
                id: el.id,
                name: idObat.name,
                qty: el.qty,
                price: idObat.price,
                total_price: el.qty * idObat.price
            };
            updatedList.push(updatedMedicine);
        }
        
        
        // console.log("INIIIII>>>",list_medicines);
        await PemesananObat.create({
            id_user: id_user, // id_user dari body
            list_medicines: JSON.parse(JSON.stringify(list_medicines)) // list_medicines dari body
        });
        let result = {
            status:true,
            message:"success",
            data:updatedList
        }
        res.status(201).json(result);
        } catch (error){
        // console.error(error);
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
        const token = req.header('Authorization')?.split(' ')[1];
        // console.log('Request Headers:', req.headers);
        if (!token) {
            throw { name: 'UnauthorizedError' };
        }
          
        // Verify the token
        // console.log('Token:', token);
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userbyToken = await User.findByPk(decoded.id);
        if (!userbyToken) {
            throw { name: 'UserNotFoundError' };
        }
        const id_user = userbyToken.id;
        const users = await PemesananObat.findAll({ where: { id_user } })
        if (!users || users.length === 0){
            throw { name: 'OrdersNotFoundError' };
        }
        const orderDetails = [];
        for (const user of users) {
            const medicines = user.list_medicines;
            const medicineDetails = [];
            for (const medicine of medicines) {
                // console.log("MEDICINE=>>",medicine);
                const idObat = await Obat.findOne({ where: { id: medicine.id } });
                if (!idObat) {
                    // throw { name: "OrdersNotFoundError" };
                    res.status(404).json({'message':'Orders not found.'})
                }
                medicineDetails.push({
                    id: idObat.id,
                    name: idObat.name,
                    qty: medicine.qty,
                    price: idObat.price,
                    total_price: medicine.qty * idObat.price
                });
            }
            orderDetails.push({
                id_struct: user.id,
                id_user: user.id_user,
                list_medicines: medicineDetails
            });
        }

        let result = {
            status:true,
            message:"success",
            data:orderDetails
        }
        res.status(200).json(result);
    } catch (error) {
        // console.error(error);
        if (error.name === 'UnauthorizedError'){
            res.status(401).json({ message: 'Access denied. No token provided.' });
        }else if (error.name === 'UserNotFoundError') {
            res.status(404).json({ message: 'User not found.' });
        }else if (error.name === 'OrdersNotFoundError') {
            res.status(404).json({ message: 'Orders not found.' });
        }else{
            res.status(500).json({ message: 'Internal Server Error' });
        }
    }
};
const postCartOrder = async(req,res) => {
    try{
        const { id_user, list_medicines } = req.body;
        const user = await User.findOne({ where: { id:id_user } });
        // console.log("user>>>>",user);
        if (!user){
            throw{name:"InvalidData"}
        }
        for (el of list_medicines){
            const idObat= await Obat.findOne({where:{id:el.id} });
            // console.log("idOBAT>>>",idObat,"obatnya>>", el.id);
            if (!idObat) throw{name:"Datanotfound"}
            if (idObat.stock <= 0) {
                throw { name: "OutOfStock" };
            }
            el.name = idObat.name;
            el.price = idObat.price;
        }
        let cart = await Cart.findOne({ where: { id_user } });
        // console.log("INIIIII=>>>>",cart.dataValues);
        // console.log("LIST=>>>",list_medicines);
        // Jika tidak ada data cart, buat baru
        if (!cart) {
            cart = await Cart.create({ id_user, list_medicines });
        } else {
             // Map untuk menyimpan obat yang sudah ada di dalam keranjang
             const cartMap = new Map(cart.list_medicines.map(item => [item.id, item]));

             list_medicines.forEach(newMedicine => {
                 // Jika obat belum ada di dalam keranjang, tambahkan
                 if (!cartMap.has(newMedicine.id)) {
                     cartMap.set(newMedicine.id, newMedicine);
                 }
             });
 
             // Simpan kembali list obat yang telah diperbarui ke dalam keranjang
             cart.list_medicines = Array.from(cartMap.values());
 
             // Simpan kembali cart ke dalam database
             await cart.save();
        
        }
        let result = {
            status:true,
            message:"success",
            data:cart.list_medicines
        }
        res.status(201).json(result);
        } catch (error){
        // console.error(error);
        if (error.name=="InvalidData"){
            res.status(401).json({message:'User not found'})
        }else if (error.name=="Datanotfound"){
            res.status(404).json({message:'id obat not found'})
        }else if (error.name === "OutOfStock") {
            res.status(400).json({ message: "Stock is not enough" });
        }else {
            res.status(500).json({ message: 'Internal Server Error' });
        }
            
    }
    
};
const deleteCartItem = async (req, res) => {
    try {
        const { id_user, list_medicines: list_medicinesString } = req.params;
        const list_medicines = JSON.parse(list_medicinesString);

        let cart = await Cart.findOne({ where: { id_user } });
        if (!cart) {
            throw { name: "CartNotFound" };
        }

        // Filter list_medicines untuk menghapus item dengan id yang sesuai
        cart.list_medicines = cart.list_medicines.filter(item => item.id !== list_medicines[0].id);

        // Simpan perubahan ke dalam database
        await cart.save();

        // Menanggapi permintaan penghapusan dengan sukses
        let result = {
            status:true,
            message:"success",
            data:cart.list_medicines
        }
        res.status(200).json(result);
    } catch (error) {
        console.error(error);
        if (error.name === "CartNotFound") {
            res.status(404).json({ message: "Cart not found" });
        } else {
            res.status(500).json({ message: "Internal Server Error" });
        }
    }
};

module.exports = {
    checkoutOrder,
    getHistoryOrder,
    postCartOrder,
    deleteCartItem
};