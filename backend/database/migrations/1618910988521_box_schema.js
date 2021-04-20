'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class BoxSchema extends Schema {
  up () {
    this.create('boxes', (table) => {
      table.increments().unsigned()
      table.integer('creator').unsigned().notNullable()
      table.string('title', 10).notNullable()
      table.string('context', 255).notNullable()
      table.string('color', 20).notNullable().defaultTo('white')
      table.timestamps()

      table.foreign('creator').references('id').inTable('users').onDelete('CASCADE')
    })
  }

  down () {
    this.drop('boxes')
  }
}

module.exports = BoxSchema
