import { DateTime } from 'luxon'
import {
  BaseModel,
  BelongsTo,
  belongsTo,
  column
} from '@ioc:Adonis/Lucid/Orm'
import User from './User'

export default class Box extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: null })
  public creatorId: number

  @belongsTo(() => User, {
    foreignKey: 'creatorId',
    localKey: 'id'
  })
  public creator: BelongsTo<typeof User>

  @column()
  public title: string

  @column()
  public context: string

  @column()
  public color: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
