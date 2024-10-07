#!/bin/bash

# Update package list and upgrade existing packages
sudo apt update -y
sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Start Nginx service
# sudo systemctl start nginx

sudo apt-get update
sudo apt-get install -y ruby wget

# Download and install the CodeDeploy agent
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

# Start the CodeDeploy agent
sudo service codedeploy-agent start

# Install Node.js and npm
echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
echo "Verifying Node.js and npm installation..."
node -v
npm -v

# Install PM2 globally
echo "Installing PM2..."
sudo npm install -g pm2


# Install simple health heck 
# Create a directory for the health check app
mkdir -p /home/ubuntu/health-check-app
cd /home/ubuntu/health-check-app

# Create a simple Node.js app
cat <<EOL > server.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(port, '0.0.0.0' ,() => {
  console.log(\`Health check app listening on port \${port}\`);
});
EOL

# Initialize a package.json file and install express
sudo npm init -y
sudo npm install express

# Run the health check app in the background 
sudo pm2 start server.js --name health-check-app
sudo pm2 save