import { rules, schema } from '@ioc:Adonis/Core/Validator'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class CreateBoxValidator {
	constructor(protected ctx: HttpContextContract) {
	}

	public schema = schema.create({
		'title': schema.string({ trim: true }, [
			rules.maxLength(10)
		]),
		'context': schema.string({ trim: true }, [
			rules.maxLength(150)
		]),
		'color': schema.enum([ 'red', 'orange', 'green' ]),
		'anonymous': schema.boolean()
	})

	public messages = {
		'required': '{{ field }} is required',
		'maxLength': '{{ field }} can have {{ options.maxLength }} characters at most',
		'enum': '{{ field }} choices are {{ options.choices }}',
		'boolean': '{{ field }} can be true or false'
	}
}
