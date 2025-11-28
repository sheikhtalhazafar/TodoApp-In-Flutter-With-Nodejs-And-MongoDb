const jwt = require('jsonwebtoken')

function generateToken(id) {
    return jwt.sign({ id }, 'abcd1234@*')
}

module.exports = { generateToken }