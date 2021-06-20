import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Game from 'App/Models/Game'
import GameBox from 'App/Models/GameBox'
import CreateGameValidator from 'App/Validators/CreateGameValidator'

const State = { 'created': 0, 'inprogress': 1, 'finished': 2 }

export default class GamesController {
  public async create({ request, response, params, auth }: HttpContextContract) {
    // create game
    await request.validate(CreateGameValidator)
    const { title } = request.only(['title'])
    const game = await Game.create({
      creatorId: auth.user ? auth.user.id : undefined,
      state: State['created'],
      title
    })
    // create gameboxes
    for (let i = 0; i < 10; i++) {
      let num = params['numbers'][i]
      await GameBox.create({ boxId: num, gameId: game.id })
    }
    // load boxes
    await game.load('boxes')
    for (let i = 0; i < game.boxes.length; i++)
      await game.boxes[i].load('box')
    response.status(201).json(game)
  }

  public async retrieve({ response }: HttpContextContract) {
    const games = await Game.query().select('*').from('games').where('state', '0').orWhere('state', '1').exec()
    response.status(200).json(games)
  }
}
