'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */
    const data = require('../data/pemesananObat.json')
    data.forEach(el=>{
      el.createdAt = new Date()
      el.updatedAt = new Date()
      el.list_medicines = JSON.stringify(el.list_medicines)
    })
    await queryInterface.bulkInsert('PemesananObats',data,{})
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    await queryInterface.bulkDelete('PemesananObats', null, {});
  }
};
