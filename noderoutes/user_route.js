const express = require('express')
const { register, verifyOtp, login } = require('../nodecontrollers/userController')
const { requiredFieldsWhenRegister } = require('../nodeMiddleware/userProtection')
const routes = express.Router()
const upload = require('../nodeMiddleware/multer_middleware');

routes.post('/register', upload.single('profileImage'), requiredFieldsWhenRegister, register)
routes.post('/verifyOtp', verifyOtp)
routes.post('/login', login)

module.exports = routes
