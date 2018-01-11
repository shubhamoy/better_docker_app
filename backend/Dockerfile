# Install nodejs alpine image
FROM node:alpine

# Create app directory
RUN mkdir -p /usr/src/app

# Switch to app directory
WORKDIR /usr/src/app

# Bundle App Source
COPY . /usr/src/app

# Install app dependencies & pm2 globally
RUN npm install pm2 -g

# Start app with PM2
CMD ["pm2-docker", "start", "npm", "--", "start"]