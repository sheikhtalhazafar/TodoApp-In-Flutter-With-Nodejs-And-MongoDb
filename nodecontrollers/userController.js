const newUser = require('../nodemodel/userModel');
const bcrypt = require("bcryptjs")
const { generateToken } = require('../tokenGenerator');

async function register(req, res) {
    try {
        let user
        const { username, email, password } = req.body;
        user = await newUser.findOne({ email })
        if (user) {
            return res.status(500).json({
                message: "User already Exists",
            })
        }

        const hashedPass = await bcrypt.hash(password, 10);
        user = await newUser.create({
            username, email, password: hashedPass, profileImage: req.file ? `/uploads/${req.file.filename}` : null
        })

        // Remove password before sending response
        const userData = {
            _id: user._id,
            username: user.username,
            email: user.email,
            profileImage: user.profileImage
        };

        return res.status(201).json({
            message: "User Created Successfully",
            token: generateToken(user._id),
            userDetails: userData
        })

    } catch (err) {
        return res.status(500).json({
            message1: "Server Error",
            message2: err.message
        })
    }
}



async function login(req, res) {
    try {
        let user
        const { email, password } = req.body;
        user = await newUser.findOne({ email });
        if (!user) {
            return res.status(400).json({
                message: "No user Found with this email"
            })
        }

        const isMatch = await bcrypt.compare(password, user.password)
        if (!isMatch) {
            return res.status(400).json({
                message: "Wrong Password"
            })
        }
        const imageUrl = user.profileImage
            ? `http://192.168.1.15:45702${user.profileImage}`
            : null;
        // Remove password before sending response
        const userData = {
            _id: user._id,
            username: user.username,
            email: user.email,
            profileImage: imageUrl
        };
        return res.status(200).json({
            message: "User Logged in Successfully",
            token: generateToken(user._id),
            userDetails: userData
        })

    } catch (err) {
        return res.status(500).json({
            message1: "Server Error",
            message2: err.message
        })
    }
}


module.exports = {
    register,
    login
}