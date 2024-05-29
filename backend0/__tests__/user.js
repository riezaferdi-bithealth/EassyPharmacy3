const request= require('supertest')
const {sequelize} = require("../models")
const bcrypt = require("bcrypt")
const app = require('../app')


beforeAll(async()=>{
    const data = require('../data/user.json')

    data.forEach(el=>{

        el.password =  bcrypt.hashSync(el.password,10)
        el.createdAt = new Date()
        el.updatedAt = new Date()
      })
    await sequelize.queryInterface.bulkInsert('Users',data,{})
})

afterAll(async()=>{
    await sequelize.queryInterface.bulkDelete('Users',null,{
            truncate: true,
            cascade: true,
            restartIdentity: true
    })
})

describe('USER TESTING', ()=>{
    describe('/user/register - REGISTER TESTING',()=>{
        // tambahin usecasenya bukan hanya 201
        it('Response 201 - success register user',async ()=>{
            const body = {
                "fullname":"ilyasa",
                "email":"ilyas@mail.com",
                "password":"sapiperah",
                "phoneNumber":"081143215678"
            }
            const result = await request(app).post('/user/register').send(body)
            expect(result.status).toBe(201)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
            // console.log(result);
        });
        it('Response 400 - invalid email format', async () => {
            const body = {
                "fullname": "ilyasa",
                "email": "ilyasa.com", // Invalid email format
                "password": "password",
                "phoneNumber": "081234567890"
            };
            const result = await request(app).post('/user/register').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Invalid email address or phone number');
        });
        it('Response 400 - invalid phone number length', async () => {
            const body = {
                "fullname": "ilyasa",
                "email": "ilyasa@mail.com",
                "password": "password",
                "phoneNumber": "12345" // Phone number length less than 10
            };
            const result = await request(app).post('/user/register').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Invalid email address or phone number');
        });
        it('Response 400 - email already exists', async () => {
            const body = {
                "fullname": "ferdy",
                "email": "ferdy@gmail.com", // Existing email
                "password": "password",
                "phoneNumber": "081234567890"
            };
            const result = await request(app).post('/user/register').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Email already exists');
        });

        it('Response 400 - missing required fields', async () => {
            const body = {
                "fullname": "Missing Fields User",
                // Missing email, password, and phoneNumber
            };
            const result = await request(app).post('/user/register').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Missing required fields: fullname, email, password, phoneNumber');
        });

    });
    describe('/user/login - LOGIN TESTING',()=>{
        it('Response 200 - success login user', async ()=>{
            // + usecasenya ga hanya 200, 404,400
            const body = {
                "email":"iyasaffan@gmail.com",
                "password":"ilyasilyasa"
            }
            const result = await request(app).post('/user/login').send(body)
            // console.log(result)
            expect(result.status).toBe(200)
            expect(result.body).toHaveProperty('status',true)
            expect(result.body).toHaveProperty('message','success')
        });
        it('Response 404 - user not found', async () => {
            const body = {
                "email": "usernotfound@mail.com", // email tidak ada
                "password": "password"
            };
            const result = await request(app).post('/user/login').send(body);
            expect(result.status).toBe(404);
            expect(result.body).toHaveProperty('message', 'User not found');
        });

        it('Response 400 - invalid password', async () => {
            const body = {
                "email": "iyasaffan@gmail.com",
                "password": "invalidpassword"
            };
            const result = await request(app).post('/user/login').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Invalid Password');
        });
        it('Response 400 - Missing Fields', async () => {
            const body = {
                "email": "", // email tidak ada
                "password": "" // pass tidak ada
            };
            const result = await request(app).post('/user/login').send(body);
            expect(result.status).toBe(400);
            expect(result.body).toHaveProperty('message', 'Missing required fields: fullname, email, password, phoneNumber');
        });
    })

    })
    