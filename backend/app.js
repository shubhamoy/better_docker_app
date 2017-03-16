"use strict";
let NRP = require("node-redis-pubsub");
let redis_host = process.env.REDIS_HOST || "127.0.0.1";
let redis_port = process.env.REDIS_PORT || 6379;

let config = {
  port: redis_port,
	host: redis_host,
	scope: "demo"
};
let server = new NRP(config);

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

setInterval(() => {
  let recData = getRandomInt(50, 100);
	let tataData = getRandomInt(75, 150);
	let gailData = getRandomInt(25, 125);

	server.emit("tickerData", [{rdata: recData},
                             {tdata: tataData},
                             {gdata: gailData}]
	);
}, 2000);
console.log("Backend Server Running");