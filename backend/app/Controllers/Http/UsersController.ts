import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User'
import UserSigninValidator from 'App/Validators/UserSigninValidator'
import UserSignupValidator from 'App/Validators/UserSignupValidator'

export default class UsersController {
    public async signin({ request, response, auth }: HttpContextContract) {
        await request.validate(UserSigninValidator)
        const { username, email, password } = request.only(['username', 'email', 'password'])
        const uid = username? username: email
        const token = await auth.attempt(uid, password, {expiresIn: '30days'})
        response.status(200).json({'token': 'bearer ' + token.token})
    }

    public async signup({ request, response, auth }: HttpContextContract) {
        await request.validate(UserSignupValidator)
        const { username, email, password } = request.only(['username', 'email', 'password'])
        const user = await User.create({ username, email, password })
        const token = await auth.login(user)
        const obj = user.serialize()
        obj.token = 'bearer ' + token.token
        response.status(201).json(obj)
    }

    public async signout({ response, auth }: HttpContextContract) {
        await auth.logout()
        response.accepted({ 'message': 'logged out successfully' })
    }
}
