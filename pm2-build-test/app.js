const http = require('http');

const server = http.createServer((req, res) => {
  res.write('hello world!');
  res.end();
});
server.on('clientError', (err, socket) => {
  socket.end('HTTP/1.1 400 Bad Request\r\n\r\n');
});
server.listen(8000, (err)=>{
  if(!err) console.log('server is running on 8000');
});