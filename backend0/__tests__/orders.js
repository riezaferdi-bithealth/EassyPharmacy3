const request= require('supertest')
const {sequelize} = require("../models")
const app = require('../app')
const bcrypt = require("bcrypt")
const jwt = require('jsonwebtoken');
const { User, PemesananObat, Obat, Cart } = require('../models');
let authToken;

beforeAll(async()=>{
    const data = require('../data/pemesananObat.json')
    const obat = require('../data/obat.json')
    const user = require('../data/user.json')
    // await sequelize.queryInterface.dropTable('PemesananObats')
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
    await sequelize.queryInterface.bulkInsert('Users',user,{})
    await sequelize.queryInterface.bulkInsert('PemesananObats',data,{})
    await sequelize.queryInterface.bulkInsert('Obats',obat,{})
    
    // Lakukan login untuk mendapatkan token JWT
    // const loginResponse = await request(app)
    //     .post('/user/login')
    //     .send({ email: 'iyasaffan@gmail.com', password: 'ilyasilyasa' }); // Ganti dengan kredensial yang sesuai
    // authToken = loginResponse.body.mobile_fcm_token;
})

afterAll(async()=>{
    await sequelize.queryInterface.bulkDelete('Obats',null,{
            truncate: true,
            cascade: true,
            restartIdentity: true

    })
    await sequelize.queryInterface.bulkDelete('PemesananObats',null,{
            truncate: true,
            cascade: true,
            restartIdentity: true

    })
    await sequelize.queryInterface.bulkDelete('Users',null,{
            truncate: true,
            cascade: true,
            restartIdentity: true

    })
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

    describe('/orders/cart - CART TESTING',()=>{
      it('Response 201 - success cart',async ()=>{
          const body = {
              "id_user": 1, // id user belum ada di 
              "list_medicines": [
                {
                  "id": 1,
                  "price": 7500
                }
              ]
            }
          const result = await request(app).post('/orders/cart').send(body)
          expect(result.status).toBe(201)
          expect(result.body).toHaveProperty('status',true)
          expect(result.body).toHaveProperty('message','success')
          // console.log(result);
      });
      it('Response 201 - success cart',async ()=>{
        const body = {
            "id_user": 1, // id user sudah ada
            "list_medicines": [
              {
                "id": 3,
                "price": 7500
              }
            ]
          }
        const result = await request(app).post('/orders/cart').send(body)
        expect(result.status).toBe(201)
        expect(result.body).toHaveProperty('status',true)
        expect(result.body).toHaveProperty('message','success')
        // console.log(result);
      });
      it('Response 401 - Invalid Data',async ()=>{
        const body = {
            "id_user": 100, // id user invalid
            "list_medicines": [
              {
                "id": 1,
                "price": 7500
              }
            ]
          }
        const result = await request(app).post('/orders/cart').send(body)
        expect(result.status).toBe(401)
        expect(result.body).toHaveProperty('message','User not found')
        // console.log(result);
      });
      it('Response 404 - Data not Found',async ()=>{
        const body = {
            "id_user": 1, // id user invalid
            "list_medicines": [
              {
                "id": 100, // id obat invalid
                "price": 7500
              }
            ]
          }
        const result = await request(app).post('/orders/cart').send(body)
        expect(result.status).toBe(404)
        expect(result.body).toHaveProperty('message','id obat not found')
        // console.log(result);
      });
      it('Response 400 - Out of stock',async ()=>{
        const body = {
            "id_user": 1, 
            "list_medicines": [
              {
                "id": 20, // id obat yang stocknya 0
                "price": 7500
              }
            ]
          }
        const result = await request(app).post('/orders/cart').send(body)
        expect(result.status).toBe(400)
        expect(result.body).toHaveProperty('message','Stock is not enough')
        // console.log(result);
      });
      
    })

    describe('/orders/history - HISTORY TESTING',()=>{
      it('Response 200 - success history',async ()=>{
          // console.log("INI TOKEN=>>",authToken);
          let authToken=jwt.sign({ id: 1 }, process.env.JWT_SECRET);
          const result = await request(app)
          .get('/orders/history')
          .set('Authorization', `Bearer ${authToken}`);
          expect(result.status).toBe(200);
          expect(result.body).toHaveProperty('status',true);
          expect(result.body).toHaveProperty('message','success');
          // console.log(result);
      });
      it('Response 401 - no token provided', async () => {
        const result = await request(app)
            .get('/orders/history');
        expect(result.status).toBe(401);
        expect(result.body).toHaveProperty('message', 'Access denied. No token provided.');
      });
      it('Response 404 - user not found', async () => {
        // Buat token yang valid tetapi tidak ada pengguna terkait
        const token = jwt.sign({ id: 999 }, process.env.JWT_SECRET);
    
        // Mock fungsi untuk mengembalikan null (tidak ada pengguna)
        jest.spyOn(User, 'findByPk').mockResolvedValue(null);
    
        // Panggil endpoint '/orders/history' dengan token yang valid tetapi pengguna tidak ditemukan
        const result = await request(app)
          .get('/orders/history')
          .set('Authorization', `Bearer ${token}`);
    
        // Periksa respons dari server
        expect(result.status).toBe(404);
        expect(result.body).toHaveProperty('message', 'User not found.');
      });
      it('should throw OrdersNotFoundError if no orders are found', async () => {
        // Mocking the required dependencies
        jest.spyOn(User, 'findByPk').mockResolvedValue({ id: 1 });
        jest.spyOn(PemesananObat, 'findAll').mockResolvedValue([]);
    
        // Perform the request
        const token = jwt.sign({ id: 1 }, process.env.JWT_SECRET);
        const response = await request(app)
            .get('/orders/history')
            .set('Authorization', `Bearer ${token}`);
    
        // Verify the response
        expect(response.status).toBe(404);
        expect(response.body).toHaveProperty('message', 'Orders not found.');
      });
      it('Response 404 - Order Not Found Error',async ()=>{
        // console.log("ILYASSSSSS=>>");
        let authToken=jwt.sign({ id: 1 }, process.env.JWT_SECRET);
        // console.log("AUTH TOKEN=>>",authToken);
        const result = await request(app)
        .get('/orders/history')
        .set('Authorization', `Bearer ${authToken}`);
        expect(result.status).toBe(404);
        console.log("ILYASSSS=>>");
        expect(result.body).toHaveProperty('message','Orders not found.');
        console.log(result);
      });

      describe('/orders/cart/item - DELETE CART TESTING',()=>{
        it('Response 200 - success delete cart',async ()=>{
            const result = await request(app).delete('/orders/cart/item/1/[{"id": 3,"price": 7500}]')
            expect(result.status).toBe(200)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
            // console.log(result);
        });
        it('Response 404 - Cart not found',async()=>{
            const result = await request(app).delete('/orders/cart/item/17/[{"id": 3,"price": 7500}]')
            expect(result.status).toBe(404)
            expect(result.body).toHaveProperty('message','Cart not found')
        })
      })
  });
})