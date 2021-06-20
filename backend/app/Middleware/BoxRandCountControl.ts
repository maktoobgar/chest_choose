import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Box from 'App/Models/Box'

export default class BoxRandCountControl {
  public async handle({ response, params }: HttpContextContract, next: () => Promise<void>) {
    params['total'] = (await Box.query().count('* as total'))[0].$extras['total']
    if (params['total'] < 10) { response.status(406).json({'message': 'there are not enough boxes in database'}) }
    let reserved: number[] = []
    // generate gameboxes
    for (let i = 0; i < 10;) {
      const rand = Math.floor(Math.random() * params['total']) + 1
      if (!(rand in reserved)) {
        reserved.push(rand)
        i += 1
      }
    }
    params['numbers'] = reserved
    await next()
  }
}
