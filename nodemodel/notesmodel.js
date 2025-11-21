const mongoose = require('mongoose')


const noteSchema = mongoose.Schema({
    notes: {
        type: String, required: true,
    }
})

const Usernotes = mongoose.model('Usernotes', noteSchema)

module.exports = Usernotes