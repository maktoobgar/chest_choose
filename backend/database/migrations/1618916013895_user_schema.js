'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class UserSchema extends Schema {
  up () {
    this.table('users', (table) => {
      table.foreign('box').references('id').inTable('boxes').onDelete('SET NULL')
    })
  }

  down () {
    this.table('users', (table) => {
      table.dropForeign('box')
    })
  }
}

module.exports = UserSchema
