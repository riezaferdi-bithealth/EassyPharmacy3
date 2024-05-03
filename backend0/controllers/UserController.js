const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { User } = require('../models');

const UserController = {
  async register(req, res) {
    try {
    console.log(req.body)
    const { fullname, email, password, phoneNumber } = req.body;
    // if(!email || !password) throw{name:"InvalidData"}
    // const checkEmail = email.split('@')
    // coba pakai validation sequelize is email
    // if (checkEmail.length < 2){
    //     throw{name:"InvalidData"}
    // }
    // if(phoneNumber<10) throw{name:"InvalidData"}
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
      if (error.name = "InvalidData"){
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
            return res.status(401).json({ message: 'User not found' });
            // pastikan lagi status user not found lagi
        }
        const validPassword = await bcrypt.compare(password, user.password);
        if (!validPassword) {
            return res.status(400).json({ message: 'Invalid password' });
        } 
        // recheck status invalid pass 
        const token = jwt.sign({ id: user.id }, 'your-secret-key');
      // res.status(200).json({ token });
      const result = {
        status:true,
        message:"success",
        user,
        mobile_fcm_token:token
      }
      res.status(200).json(result);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Internal Server Error' });
    }
  }
};

module.exports = UserController;

