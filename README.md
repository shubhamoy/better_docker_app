# Better Docker App
![Better Docker App](screenshot.jpg)

An app built using node.js, socket.io and redis for demonstrating the simplicity of docker. 

# App Structure
* Redis Container: It runs a Redis Instance.
* Frontend Container: It fetches the data from the Redis Container.
* Backend Container: It pushes data to the Redis Container.

# How to use the app?
* Your system must have docker installed. https://docs.docker.com/engine/installation/
* Clone/Download this repo 
* Run `docker-compose up`. Ensure no service is running at port 3000.
* Open your browser at http://127.0.0.1:3000

# Queries
Open an issue or drop a mail at me@shubhamoy.com

# Credits
https://github.com/mattkanwisher/demo_stocks_digitalocean/
