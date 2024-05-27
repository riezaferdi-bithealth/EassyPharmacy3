'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Cart extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Cart.init({
    id_user: {
      type:DataTypes.INTEGER,
      primaryKey: true},
    list_medicines: DataTypes.JSONB
  }, {
    sequelize,
    modelName: 'Cart',
  });
  return Cart;
};