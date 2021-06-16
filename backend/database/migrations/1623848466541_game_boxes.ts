import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class GameBoxes extends BaseSchema {
  protected tableName = 'game_boxes'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer('box_id').notNullable().references('id').inTable('boxes').onDelete('RESTRICT')
      table.integer('game_id').notNullable().references('id').inTable('games').onDelete('CASCADE')
      table.boolean('lock').notNullable().defaultTo(false)
      table.boolean('open').notNullable().defaultTo(false)

      table.timestamp('created_at', { useTz: true })
      table.timestamp('updated_at', { useTz: true })
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
