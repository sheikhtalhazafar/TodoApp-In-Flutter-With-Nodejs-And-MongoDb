const express = require('express')
const { register, login } = require('../nodecontrollers/userController')
const { requiredFieldsWhenRegister } = require('../nodeMiddleware/userProtection')
const routes = express.Router()
const upload = require('../nodeMiddleware/multer_middleware');

routes.post('/register', upload.single('profileImage'), requiredFieldsWhenRegister, register)

routes.post('/login', login)

module.exports = routes
