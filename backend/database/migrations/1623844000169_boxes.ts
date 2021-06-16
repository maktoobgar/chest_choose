import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Boxes extends BaseSchema {
  protected tableName = 'boxes'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer('creator').unsigned().references('id').inTable('users').onDelete('RESTRICT').nullable()
      table.string('title', 10).notNullable()
      table.string('context', 150).notNullable()
      table.enum('color', [0, 1, 2]).notNullable().defaultTo(0)

      table.timestamp('created_at', { useTz: true })
      table.timestamp('updated_at', { useTz: true })
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}
