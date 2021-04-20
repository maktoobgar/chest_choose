'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class GBoxSchema extends Schema {
  up () {
    this.create('g_boxes', (table) => {
      table.increments().unsigned()
      table.integer('game_id').unsigned().notNullable()
      table.integer('box_id').unsigned().notNullable()
      table.boolean('locked').notNullable().defaultTo(false)
      table.boolean('opened').notNullable().defaultTo(false)
      table.timestamps()
      
      table.foreign('box_id').references('id').inTable('boxes')
      table.foreign('game_id').references('id').inTable('games')
    })
  }

  down () {
    this.drop('g_boxes')
  }
}

module.exports = GBoxSchema
