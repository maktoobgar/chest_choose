import ws from 'ws'

class Ws {
  public io: ws
  private booted = false

  public boot() {
    if (this.booted) {
      return
    }

    this.booted = true
    this.io = new ws.Server({ 
      port: 3332,
      maxPayload: 1024 /* maximum allowed message size in bytes */ 
    })
  }
}

export default new Ws()
