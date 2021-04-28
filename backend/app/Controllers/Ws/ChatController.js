'use strict'

class ChatController {
  constructor ({ socket, request }) {
    this.socket = socket
    this.request = request
    console.log('connected')
  }
  onMessage (message) {
    console.log(message)
  }
}

module.exports = ChatController
