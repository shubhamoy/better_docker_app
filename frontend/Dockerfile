# Install node.js v6.10 LTS
FROM node:boron

# Create app directory
RUN mkdir -p /usr/src/app

# Switch to app directory
WORKDIR /usr/src/app

# Bundle App Source
COPY . /usr/src/app

# Install app dependencies
RUN npm install

# Install PM2 Globally
RUN npm install pm2 -g

# Start app with PM2
CMD ["pm2-docker", "start", "npm", "--", "start"]

# Open port
EXPOSE 3000
