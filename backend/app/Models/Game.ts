import { DateTime } from 'luxon'
import { 
  BaseModel,
  column,
  BelongsTo,
  belongsTo,
  HasMany,
  hasMany
} from '@ioc:Adonis/Lucid/Orm'
import User from 'App/Models/User'
import GameBox from 'App/Models/GameBox'

export default class Game extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: null })
  public creator_id: number

  @column()
  public state: string

  @belongsTo(() => User, {
    foreignKey: 'creatorId',
    localKey: 'id'
  })
  public creator: BelongsTo<typeof User>
  
  @hasMany(() => GameBox, {
    foreignKey: 'gameId',
    localKey: 'id'
  })
  public boxes: HasMany<typeof GameBox>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
