'use strict'

class ChatController {
  constructor ({ socket, request }) {
    this.socket = socket
    this.request = request
    console.log('print')
  }
  onMessage (message) {
    this.socket.broadcastToAll('message', message)
    console.log('print')
  }
}

module.exports = ChatController
