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
    await sequelize.queryInterface.bulkDelete('Obats',null,{
        truncate: true,
        cascade: true,
        restartIdentity: true
})
})
describe('OBAT TESTING', () => {
    describe('/drug/ - GET ALL OBAT TESTING', () => {
        it('Response 200 - get all drugs', async () => {
            // console.log("misah");
            const result = await request(app).get('/drug/');
            expect(result.status).toBe(200);
            expect(result.body.status).toBe(true);
            expect(result.body.message).toBe('success');
            expect(Array.isArray(result.body.data)).toBe(true);
         });
        it('Response 200 -get by drugs name', async ()=>{
            const result= await request(app).get('/drug/?search=lade').query({ key: 'name' });
            expect(result.body.status).toBe(true);
            expect(result.body.message).toBe('success');
        });
        it('Response 200 - success pagination and search', async () => {
            const result = await request(app)
                .get('/drug')
                .query({ search: 'cetam', 'page[size]': 5, 'page[number]': 1 });
        
            expect(result.status).toBe(200);
            // Evaluasi lebih lanjut sesuai dengan respons yang diharapkan
        });
        it('should not set limit and offset when page size and number are not provided', async () => {
            const result = await request(app)
                .get('/drug/');
        
            expect(result.status).toBe(200);
            expect(result.body.status).toBe(true);
            expect(result.body.message).toBe('success');
            expect(Array.isArray(result.body.data)).toBe(true);
        });
        
    });
});