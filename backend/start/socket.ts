import Ws from 'App/Services/Ws'
Ws.boot()


Ws.io.on('connection', (client) => {
  // client.emit('news', { hello: 'world' })

  client.send(JSON.stringify({
    "welcome": true
  }))

  client.on('upgrade', async (request, socket, head) => {
    // Do what you normally do in `verifyClient()` here
  
    Ws.io.handleUpgrade(request, socket, head, function done(ws) {
      Ws.io.emit('connection', ws, request, ...args);
    });
  });

  client.on('message', (data) => {
    console.log(data)
  })
})
