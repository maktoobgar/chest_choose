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

  @belongsTo(() => User)
  public creator: BelongsTo<typeof User>
  
  @hasMany(() => GameBox)
  public boxes: HasMany<typeof GameBox>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
