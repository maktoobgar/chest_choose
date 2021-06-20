import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Box from 'App/Models/Box'
import CreateBoxValidator from 'App/Validators/CreateBoxValidator'

const Color = { 'red': 0, 'orange': 1, 'green': 2 }

export default class BoxesController {
    public async create({ request, response, auth }: HttpContextContract) {
        await request.validate(CreateBoxValidator)
        const { title, context, color, anonymous } = request.only(['title', 'context', 'color', 'anonymous'])
        let creatorId = 0
        if (!anonymous && auth.user) { creatorId = auth.user.id }
        const box = await Box.create({
            title,
            context,
            color: Color[color],
            creatorId: Boolean(creatorId) ? creatorId : undefined
        })
        response.status(201).json(box)
    }

    public async retrieve({ response, params }: HttpContextContract) {
        response.status(200).json(params.box)
    }

    public async list({ response, auth }: HttpContextContract) {
        const boxes = await Box.query().select('*').from('boxes').where('creatorId', auth.user ? auth.user.id : '0')
        response.status(200).json(boxes)
    }
}
