const express = require('express')
const app = express()
const mongoose = require('mongoose')
const routes = require('./noderoutes/note_routes')
const route = require('./noderoutes/user_route')
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}))

mongoose.connect('mongodb+srv://talhaDB:test123@nodeapp.6sb0rte.mongodb.net/?appName=NodeApp').then(() => {
    console.log('Connected to MongoDB Atlas')

    app.use('/api', routes)
    app.use('/newuser', route)
}).catch(error => {
    console.log(error)
})

// app.listen(2000, () => {
//     console.log('server is running on localhost: 2000');
// });
app.listen(45702, '0.0.0.0', () => {
    console.log('server is running on localhost: 45702');
});
