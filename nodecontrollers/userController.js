const newUser = require('../nodemodel/userModel');
const bcrypt = require("bcryptjs")
const sendotpEmail = require("../nodeemailer/emailer")
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

        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const hashedOtp = await bcrypt.hash(otp, 10);
        user = await newUser.create({
            username, email, password: hashedPass,
            otp: hashedOtp,
            otpExpiry: Date.now() + 5 * 60 * 1000, // 5 minutes
            profileImage: req.file ? `/uploads/${req.file.filename}` : null,
            isVerified: false
        })
        // Remove password before sending response
        const userData = {
            _id: user._id,
            username: user.username,
            email: user.email,
            profileImage: user.profileImage
        };

        console.log("OTP:", otp);
        await sendotpEmail(email, otp);
        return res.status(201).json({
            message: "OPT sent to your email",
            // token: generateToken(user._id),
            userDetails: userData
        })

    } catch (err) {
        return res.status(500).json({
            message1: "Server Error",
            message2: err.message
        })
    }
}


async function verifyOtp(req, res) {
    try {
        const { userid, otp } = req.body;
        console.log(userid)
        const user = await newUser.findById(userid);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        if (user.isVerified) {
            return res.status(400).json({ message: "User already verified" });
        }

        if (user.otpExpiry < Date.now()) {
            return res.status(400).json({ message: "OTP expired" });
        }

        const isOtpValid = await bcrypt.compare(otp, user.otp);
        if (!isOtpValid) {
            return res.status(400).json({ message: "Invalid OTP" });
        }

        user.isVerified = true;
        user.otp = undefined;
        user.otpExpiry = undefined;

        await user.save();

        return res.status(200).json({
            message: "OTP verified successfully",
            token: generateToken(user._id),
            userDetails: {
                _id: user._id,
                username: user.username,
                email: user.email,
                profileImage: user.profileImage
            }
        });

    } catch (err) {
        return res.status(500).json({
            message: "Server error",
            error: err.message
        });
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
            ? `http://192.168.10.4:45702${user.profileImage}`
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
    verifyOtp,
    login
}