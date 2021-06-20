import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Box from 'App/Models/Box';

export default class GetBox {
  public async handle({ params, response }: HttpContextContract, next: () => Promise<void>) {
    const box = await Box.find(params.id)
    if (!box) { response.status(404).json({ 'message': 'not found' }); return }
    await box.load('creator')
    params['box'] = box
    await next()
  }
}
