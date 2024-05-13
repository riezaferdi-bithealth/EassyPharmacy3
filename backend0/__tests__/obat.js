const request= require('supertest')
const {sequelize} = require("../models")
const app = require('../app')


beforeAll(async()=>{
    const data = require('../data/obat.json')

    data.forEach(el=>{
        el.createdAt = new Date()
        el.updatedAt = new Date()
      })
    await sequelize.queryInterface.bulkInsert('Obats',data,{})
})

afterAll(async()=>{
    await sequelize.queryInterface.bulkDelete('Obats',null,{})
})
describe('OBAT TESTING', () => {
    describe('/drug/ - GET ALL OBAT TESTING', () => {
        it('Response 200 - get all drugs', async () => {
            const result = await request(app).get('/drug/');
            expect(result.status).toBe(200);
            expect(result.body).toBeInstanceOf(Array);
         });
    });
});
    