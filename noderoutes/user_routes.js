const express = require('express')
const { post_notes,
    fetch_notes,
    update_notes,
    delete_notes } = require('../nodecontrollers/nodescontroller')
const routes = express.Router()

routes.post('/add_notes', post_notes)

routes.get('/get_notes', fetch_notes)

routes.post('/update_notes/:id', update_notes)

routes.post('/delete_notes/:id', delete_notes)

module.exports = routes