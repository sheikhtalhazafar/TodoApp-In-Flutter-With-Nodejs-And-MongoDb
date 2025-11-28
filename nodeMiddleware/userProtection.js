const jwt = require("jsonwebtoken");
const newUser = require('../nodemodel/userModel')

async function requiredFieldsWhenRegister(req, res, next) {
    const { username, email, password } = req.body
    if (!username && !email && !password) {
        return res.status(400).json({ message: "all Fields are required" })
    }
    req.user = req.body
    next()
}

    async function protectUser(req, res, next) {
        let token;

        if (req.headers.authorization?.startsWith("Bearer")) {
            token = req.headers.authorization.split(" ")[1];
            console.log("Token received:", token);
        }

        if (!token) {
            return res.status(401).json({
                message: "Not authorized user, token missing"
            });
        }

        try {
            const decoded = jwt.verify(token, "abcd1234@*");
            console.log("decoded token : ", decoded.id);

            const userDetails = await newUser.findById(decoded.id).select("-password");

            if (!userDetails) {
                return res.status(404).json({
                    message: "User not found"
                });
            }

            req.user = userDetails;   // <---- IMPORTANT
            next();

        } catch (err) {
            return res.status(500).json({
                message: "Server Error",
                error: err.message
            });
        }
    }



module.exports ={
    requiredFieldsWhenRegister,
    protectUser
}