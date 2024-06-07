require('dotenv').config({ path: `${process.cwd()}/.env` });

module.exports = {
  "development": {
    username: process.env.DB_USERNAME_DEV,
    password: process.env.DB_PASSWORD_DEV,
    database: process.env.DB_NAME_DEV,
    host: process.env.DB_HOST_DEV,
    port: process.env.DB_PORT_DEV,
    dialect: "postgres",
    seederStorage: 'sequelize',
    // "username": "postgres",
    // "password": "1315",
    // "database": "dbfinal",
    // "host": "127.0.0.1",
    // "dialect": "postgres"
  },
  "test": {
    username: process.env.DB_USERNAME_TEST,
    password: process.env.DB_PASSWORD_TEST,
    database: process.env.DB_NAME_TEST,
    host: process.env.DB_HOST_TEST,
    port: process.env.DB_PORT_TEST,
    dialect: "postgres",
    seederStorage: 'sequelize',
    // "username": "postgres",
    // "password": "1315",
    // "database": "dbfinal_test",
    // "host": "127.0.0.1",
    // "dialect": "postgres"
  },
  "production": {
    username: process.env.DB_USERNAME_PROD,
    password: process.env.DB_PASSWORD_PROD,
    database: process.env.DB_NAME_PROD,
    host: process.env.DB_HOST_PROD,
    port: process.env.DB_PORT_PROD,
    dialect: "postgres",
    seederStorage: 'sequelize',
    // "username": "root",
    // "password": null,
    // "database": "database_production",
    // "host": "127.0.0.1",
    // "dialect": "mysql"
  }
}
