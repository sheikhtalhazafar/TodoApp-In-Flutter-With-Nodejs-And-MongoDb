# Flutter + Node.js + Express + MongoDB App

A full‑stack mobile application built using **Flutter** for the frontend and **Node.js + Express** for the backend, with **MongoDB** as the database. The project follows a **clean code MVC architecture** on the backend and uses **BLoC state management** in Flutter.

---

## 🚀 Features

* Flutter frontend with clean UI
* BLoC for scalable state management
* Node.js + Express server following MVC pattern
* MongoDB database with Mongoose models
* CRUD APIs for efficient data handling
* Real‑time‑like UI updates using Bloc events
* Error handling, validation, modular code structure

---

## 🛠 Tech Stack

### **Frontend (Flutter)**

* Flutter SDK
* Dart
* BLoC State Management
* HTTP package 
* Responsive UI

### **Backend (Node.js)**

* Node.js
* Express.js
* Mongoose
* MongoDB Atlas / Local MongoDB
* MVC Folder Structure

---

## 📁 Project Structure

### **Flutter Structure**

```
lib/
│-- blocs/
│-- models/
│-- screens/
│-- services/
│-- utils/
│-- main.dart
```

### **Node.js MVC Structure**

```
backend/
│-- nodecontrollers/
│-- nodemodels/
│-- noderoutes/
│-- index.js
```

---

## 🔧 Backend Setup

### 1. Install dependencies

```
npm install
```

### 2. Setup environment variables (`.env`)

```
PORT=5000
MONGO_URI=your_mongodb_connection_string
```

### 3. Run server

```
npm start
```

---

## 📱 Flutter Setup

### 1. Install packages

```
flutter pub get
```

### 2. Run app

```
flutter run
```

---


## 📦 State Management (BLoC)

 Flutter app uses BLoC to handle:

* Fetch Notes
* Add Note
* Update Note
* Delete Note
* Auto UI refresh using Listener & events

---

## 🧹 Clean Code Practices

* Separation of concerns (MVC + BLoC)
* Reusable widgets
* Repository pattern (optional)
* Error handling on both frontend/backend

---

## 📌 Future Improvements

* Authentication (JWT)  
* Role-based access
* Real-time updates (WebSocket / Socket.io)
* Push notifications

## Feature added
* JWT Auth
* OTP Feature added
---

## 🤝 Contribution

Feel free to fork this project and submit pull requests.

---

## 📄 License

This project is open-source and free to use.
