# Docker Project: Backend & Frontend Containers

## Overview
This project contains a **backend Flask API** and a **frontend static HTML/JS app**. Below are the necessary **Docker commands** to build and run the containers.

---

## 🚀 Docker Build Commands
Before running the containers, you need to build the **backend** and **frontend** images.

### **1️⃣ Build the Backend Image**
```sh
docker build -t my-flask-api ./backend
```
🔹 -t my-flask-api → Tags the image with the name my-flask-api 🔹 ./backend → Specifies the directory containing the Dockerfile

### **2️⃣ Build the Frontend Image**
```sh
docker build -t my-frontend-app ./frontend
```
🔹 -t my-frontend-app → Tags the image with the name my-frontend-app 🔹 ./frontend → Specifies the directory containing the Dockerfile

## 🚀 Docker Run Commands
Once the images are built, you need to run the containers within the same Docker network.

### **1️⃣ Create a Network**
```sh
docker network create my_network
```
🔹 This ensures that both backend and frontend can communicate.

### **2️⃣ Run Backend Container**
```sh
docker run -d --name backend --network my_network -p 5000:5000 my-flask-api
```
🔹 -d → Runs the container in detached mode 🔹 --name backend → Names the container backend 🔹 --network my_network → Connects the container to my_network 🔹 -p 5000:5000 → Maps container’s port 5000 to host port 5000 🔹 my-flask-api → Uses the built image my-flask-api

### **3️⃣Run Frontend Container**
```sh
docker run -d --name frontend --network my_network -p 8080:80 my-frontend-app
```
🔹 -d → Runs the container in detached mode 🔹 --name frontend → Names the container frontend 🔹 --network my_network → Connects the container to my_network 🔹 -p 8080:80 → Maps host port 8080 to container’s port 80 🔹 my-frontend-app → Uses the built image my-frontend-app

### **✅ Verifying the Containers**
Once both containers are running, check their status:
```sh
docker ps
```
#### Test Backend API
Run this command to verify backend API is working:
```sh
curl http://localhost:5000/info
```

Expected Response:
```sh
{
  "hostname": "backend-container",
  "ip_address": "150.10.0.x"
}
```
#### Test Frontend API
Open your browser and visit:
```sh
http://localhost:8080
```
You should see the backend data displayed on the page.

### **📌 Notes**

If containers fail, try restarting:
```sh
docker stop backend frontend
docker rm backend frontend
docker-compose up --build
```

If network issues occur, ensure both containers are in my_network:
```sh
docker network inspect my_network
```
