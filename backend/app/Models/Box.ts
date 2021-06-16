import { DateTime } from 'luxon'
import {
  BaseModel,
  column
} from '@ioc:Adonis/Lucid/Orm'

export default class Box extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public creator: number

  @column()
  public title: string

  @column()
  public context: string

  @column()
  public color: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
