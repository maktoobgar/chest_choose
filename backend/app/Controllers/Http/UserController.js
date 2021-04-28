'use strict'

/** @typedef {import('@adonisjs/framework/src/Request')} Request */
/** @typedef {import('@adonisjs/framework/src/Response')} Response */

const Persona = use('Persona')
const User = use('App/Models/User')
const Token = use('App/Models/Token')

/**
 * Resourceful controller for interacting with users
 */
class UserController {

    /**
    * @param {object} ctx
    * @param {Request} ctx.request
    * @param {Response} ctx.response
    */
    async register({ request, response }) {
        const payload = request.only(['email', 'username', 'password', 'password_confirmation'])
        const user = await Persona.register(payload)

        const token = await user.tokens().where('type', 'email').fetch()

        response.status(201).json({
            user,
            'token': token.rows[0].token.replace(/\//g, '*')
        })
    }

    /**
    * @param {object} ctx
    * @param {Request} ctx.request
    * @param {Response} ctx.response
    */
    async login({ auth, request, response }) {
        const { username, email, password } = request.only(['username', 'email', 'password'])
        var username_user = null
        var email_user = null
        if (username) {
            username_user = await User.findBy('username', username)
        }
        if (email) {
            email_user = await User.findBy('email', email)
        }
        if (username_user && email_user) {
            if (username_user.id === email_user.id) {
                const token = await auth.withRefreshToken().attempt(email, password)
                response.status(200).json({
                    "token": token.token
                })
            }
        }
        else if (username_user) {
            const token = await auth.withRefreshToken().attempt(username_user.email, password)
            response.status(200).json({
                "token": token.token
            })
        }
        else if (email_user) {
            const token = await auth.withRefreshToken().attempt(email, password)
            response.status(200).json({
                "token": token.token
            })
        }
        else {
            response.status(400).json({
                "message": "bad request"
            })
        }
    }

    /**
    * @param {object} ctx
    * @param {Request} ctx.request
    * @param {Response} ctx.response
    */
    async email_validate({ request, response, params }) {
        const user = await Persona.verifyEmail(params.token.replace(/\*/g, '/'))

        response.status(200).json({
            'message': 'your email validated'
        })
    }

    /**
    * @param {object} ctx
    * @param {Request} ctx.request
    * @param {Response} ctx.response
    */
    show({ auth, response, params }) {
        response.status(200).json(auth.user)
    }
}

module.exports = UserController
