"use strict";
let http = require("http");
let express = require("express");
let app = express();
let port = process.env.PORT || 3000;
let host = process.env.HOST || "0.0.0.0";
let redis_host = process.env.REDIS_HOST || "127.0.0.1";
let redis_port = process.env.PORT || 6379;
let server = http.Server(app);
let io = require("socket.io")(server);
let NRP = require("node-redis-pubsub");

app.use(express.static(__dirname + "/public"));

let config = {
  port: redis_port,
	host: redis_host,
	scope: "demo"
};

let client = new NRP(config);

client.on("tickerData", (data) => {
	io.sockets.emit("tickerData", data);
});

server.listen(port, host, () => {
  console.log("Frontend Server Running");
});
