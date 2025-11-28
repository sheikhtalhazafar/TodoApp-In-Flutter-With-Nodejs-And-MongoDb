const express = require('express')
const { register, login } = require('../nodecontrollers/userController')
const { requiredFieldsWhenRegister } = require('../nodeMiddleware/userProtection')
const routes = express.Router()


routes.post('/register', requiredFieldsWhenRegister, register)

routes.post('/login', login)

module.exports = routes
