require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { User } = require('../models');
const validator = require('validator');


const UserController = {
  async register(req, res) {
    try {
    // console.log(req.body)
    const { fullname, email, password, phoneNumber } = req.body;

    if (!validator.isEmail(email)) {
      throw { name: "InvalidData", message: "Invalid email address" };
    }
    // Validasi nomor telepon menggunakan regex
    if (!/\d{10,15}/.test(phoneNumber)) {
      throw { name: "InvalidData", message: "Phone number must be between 10 and 15 digits long" };
    }
    const saltRounds = parseInt(process.env.BCRYPT_SALT_ROUNDS);
    const hashedPassword = await bcrypt.hash(password, saltRounds); 
    // salt masukan kedalam env
    const newUser = await User.create({
        fullname,
        email,
        password: hashedPassword,
        phoneNumber
      });
    console.log(newUser)
    let result = {
        status:true,
        message:"success",
        data:newUser
    }
    res.status(201).json(result);
    } catch (error) {
      console.error(error);
      if (error.name === "InvalidData"){
        res.status(400).json({message:"Invalid email,password or phone number"})
      } else{
        res.status(500).json({ message: 'Internal Server Error' });
      }
      
    }
  },

  async login(req, res) {
    try {
        console.log(req.body)
        const { email, password } = req.body;
        const user = await User.findOne({ where: { email } });
        if (!user) {
          throw{name:"UsernotFound", message:"User not found"}  
        }
        
        const validPassword = await bcrypt.compare(password, user.password);
        if (!validPassword) {
          throw {name:"InvalidData",message:"Invalid Password"}  
        }  
        const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET);
      const result = {
        status:true,
        message:"success",
        user,
        mobile_fcm_token:token
      }
      res.status(200).json(result);
    } catch (error) {
      console.error(error);
      if (error.name == "InvalidData"){
        res.status(400).json({message:"Invalid password"})
      } else if(error.name=="UsernotFound"){
        res.status(404).json({message:"User not found"})
      } else{
        res.status(500).json({ message: 'Internal Server Error' });
      }
    }
  }
};

module.exports = UserController;

