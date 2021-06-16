import { schema, rules } from '@ioc:Adonis/Core/Validator'
import { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class UserSigninValidator {
	constructor(protected ctx: HttpContextContract) {
	}

	public schema = schema.create({
		'username': schema.string.optional({ trim: true }, [
			rules.maxLength(64),
			rules.minLength(3),
			rules.requiredIfNotExists('email'),
			rules.regex(/^[a-zA-Z0-9_\-]*$/)
		]),
		'email': schema.string.optional({ trim: true }, [
			rules.maxLength(255),
			rules.email(),
			rules.requiredIfNotExists('username')
		]),
		'password': schema.string({ trim: true })
	})

	public messages = {
		'required': '{{ field }} is required',
		'maxLength': '{{ field }} can have {{ options.maxLength }} characters at most',
		'minLength': '{{ field }} can have {{ options.minLength }} characters at least',
		'requiredIfNotExists': '{{ field }} is needed when {{ options.otherField }} is not provided',
		'email': '{{ field }} is not an email',
		'regex': 'allowed characters for {{ field }} is (alphabet characters + \'-\' and \'_\' )'
	}
}
