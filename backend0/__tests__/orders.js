const request= require('supertest')
const {sequelize} = require("../models")
const app = require('../app')
const bcrypt = require("bcrypt")

beforeAll(async()=>{
    const data = require('../data/pemesananObat.json')
    const obat = require('../data/obat.json')
    const user = require('../data/user.json')
    user.forEach(el=>{
      el.password =  bcrypt.hashSync(el.password,10)
      el.createdAt = new Date()
      el.updatedAt = new Date()
    })
    obat.forEach(el=>{
        el.createdAt = new Date()
        el.updatedAt = new Date()
      })
    data.forEach(el=>{
        el.createdAt = new Date()
        el.updatedAt = new Date()
        el.list_medicines = JSON.stringify(el.list_medicines)
      })
    await sequelize.queryInterface.bulkInsert('PemesananObats',data,{})
    await sequelize.queryInterface.bulkInsert('Obats',obat,{})
    await sequelize.queryInterface.bulkInsert('Users',user,{})
})

afterAll(async()=>{
    await sequelize.queryInterface.bulkDelete('PemesananObats',null,{})
    await sequelize.queryInterface.bulkDelete('Obats',null,{})
    await sequelize.queryInterface.bulkDelete('Users',null,{})
})

describe('ORDERS TESTING', ()=>{
    describe('/orders/checkout - CHECK OUT TESTING',()=>{
        it('Response 201 - success checkout order',async ()=>{
            const body = {
                    "id_user": 1,
                    "list_medicines": [
                      {
                        "id": 1,
                        "qty": 2,
                        "price": 5000,
                        "total_price": 10000
                      }
                    ]
                };
            const result = await request(app).post('/orders/checkout').send(body)
            expect(result.status).toBe(201)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
        });
        it('Response 401 - user not found', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 100, // id user not found
                "list_medicines": [
                  {
                    "id": 1,
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).post('/orders/checkout').send(body);
            expect(result.status).toBe(401);
            expect(result.body).toHaveProperty('message', 'Invalid id');
        });
        it('Response 400 - invalid stock', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 1,
                "list_medicines": [
                  {
                    "id": 1,
                    "qty": 2000, // invalid stock
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).post('/orders/checkout').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'not enough stock');
        });
        it('Response 404 - id obat not found', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 1,
                "list_medicines": [
                  {
                    "id": 27, // id obat not found
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).post('/orders/checkout').send(body);
            expect(result.status).toBe(404);
            expect(result.body).toHaveProperty('message', 'id obat not found');
        });
    });

    describe('/orders/cart - HISTORY TESTING',()=>{
        it('Response 200 - success history',async ()=>{
            const body = {
                "id_struct": 1,
                "id_user": 1,
                "list_medicines": [
                  {
                    "id": 1,
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
              }
            const result = await request(app).get('/orders/history').send(body)
            expect(result.status).toBe(200)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
            console.log(result);
        });
        it('Response 401 - user not found', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 100, // id user not found
                "list_medicines": [
                  {
                    "id": 1,
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).get('/orders/history').send(body);
            expect(result.status).toBe(401);
            expect(result.body).toHaveProperty('message', 'User not found');
        });
    });

    describe('/orders/cart - CART TESTING',()=>{
        it('Response 201 - success cart',async ()=>{
            const body = {
                    "id_struct": 1,
                    "id_user": 1,
                    "list_medicines": [
                      {
                        "id": 1,
                        "qty": 2,
                        "price": 5000,
                        "total_price": 10000
                      }
                    ]
                }
            const result = await request(app).post('/orders/cart').send(body)
            expect(result.status).toBe(201)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
            console.log(result);
        });
        it('Response 401 - user not found', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 100, // id user not found
                "list_medicines": [
                  {
                    "id": 1,
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).post('/orders/cart').send(body);
            expect(result.status).toBe(401);
            expect(result.body).toHaveProperty('message', 'User not found');
        });
        it('Response 404 - id obat not', async () => {
            const body = {
                "id_struct": 1,
                "id_user": 1,
                "list_medicines": [
                  {
                    "id": 27, // id obat not found
                    "qty": 2,
                    "price": 5000,
                    "total_price": 10000
                  }
                ]
            };
            const result = await request(app).post('/orders/cart').send(body);
            expect(result.status).toBe(404);
            expect(result.body).toHaveProperty('message', 'id obat not found');
        });
    });
})