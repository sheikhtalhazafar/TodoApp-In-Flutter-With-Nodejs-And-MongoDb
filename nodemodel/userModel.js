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

    },
    isVerified: { type: Boolean, default: false },
    otp: String,
    otpExpiry: Date,
    profileImage: { type: String, default: null },
})

newUser = mongoose.model('registeredUsers', userSchema)
module.exports = newUser