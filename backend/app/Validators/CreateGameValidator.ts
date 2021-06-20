import { rules, schema } from '@ioc:Adonis/Core/Validator'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class CreateGameValidator {
	constructor(protected ctx: HttpContextContract) {
	}

	public schema = schema.create({
		'title': schema.string.optional({ trim: true }, [ rules.maxLength(50) ]),
	})

	public messages = {
		'maxLength': '{{ field }} can have {{ options.maxLength }} characters at most',
		'required': '{{ field }} is required'
	}
}
