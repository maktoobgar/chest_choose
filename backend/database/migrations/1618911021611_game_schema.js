'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class GameSchema extends Schema {
  up () {
    this.create('games', (table) => {
      table.increments().unsigned()
      table.integer('creator').unsigned().notNullable()
      table.integer('state').notNullable().unsigned().defaultTo(0)
      table.timestamps()

      table.foreign('creator').references('id').inTable('users').onDelete('CASCADE')
    })
  }

  down () {
    this.drop('games')
  }
}

module.exports = GameSchema
