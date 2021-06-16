import { schema } from '@ioc:Adonis/Core/Validator'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

const State = [ 'created', 'inprogress', 'finished' ]
export default class CreateGameValidator {
	constructor(protected ctx: HttpContextContract) {
	}

	public schema = schema.create({
		'state': schema.enum(State)
	})

	public messages = {
		'enum': '{{ options.choices }} are acceptable values',
		'required': '{{ field }} is required'
	}
}
