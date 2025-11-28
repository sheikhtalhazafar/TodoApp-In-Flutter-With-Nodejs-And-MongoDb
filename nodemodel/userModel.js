const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    username: {
        type: String
    },
    email: {
        type: String,
        require: true,
        unique: true

    },
    password: {
        type: String,
        require: true,

    }
})

 newUser = mongoose.model('registeredUsers', userSchema)
 module.exports = newUser