'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class PemesananObat extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  PemesananObat.init({
    id_user: DataTypes.INTEGER,
    list_medicines: DataTypes.JSONB
  }, {
    sequelize,
    modelName: 'PemesananObat',
  });
  return PemesananObat;
};