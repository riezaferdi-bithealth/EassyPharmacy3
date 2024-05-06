'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  User.init({
    fullname:{
      type: DataTypes.STRING,
      allowNull: false,
    },
    password:{
      type: DataTypes.STRING,
      allowNull:false
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: {
          msg: 'Email must be a valid email address'
        }
      }
    },
    phoneNumber: {
      type: DataTypes.STRING,
      validate: {
        isValidPhoneNumber(value) {
          if (!/\d{10,}/.test(value)) {
            throw new Error('Phone number must be at least 10 digits long');
          }
        }
      }
    }
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};