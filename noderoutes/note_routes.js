const express = require('express')
const { post_notes,
    fetch_notes,
    update_notes,
    delete_notes } = require('../nodecontrollers/nodescontroller')

const { protectUser } = require('../nodeMiddleware/userProtection')

const routes = express.Router()

routes.post('/add_notes', protectUser, post_notes)

routes.get('/get_notes', protectUser, fetch_notes)

routes.post('/update_notes/:id', protectUser, update_notes)

routes.post('/delete_notes/:id', protectUser, delete_notes)

module.exports = routes