const mongoose = require('mongoose')


const noteSchema = mongoose.Schema({
    notes: {
        type: String, required: true,
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "registeredUsers",   // model name of your user schema
        required: true
    }
})

const Usernotes = mongoose.model('Usernotes', noteSchema)

module.exports = Usernotes