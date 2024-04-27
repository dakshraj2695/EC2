const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200);
  res.end('Hello from Dockerized Node.js app!');
});

server.listen(3000, () => {
  console.log('Server listening on port 3000');
});
