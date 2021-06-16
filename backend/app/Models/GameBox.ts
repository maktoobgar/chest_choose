import { DateTime } from 'luxon'
import { 
  BaseModel,
  column, 
  HasOne, 
  hasOne
} from '@ioc:Adonis/Lucid/Orm'
import Box from 'App/Models/Box'

export default class GameBox extends BaseModel {
  @column({ isPrimary: true })
  public id: number
  
  @column({ serializeAs: null })
  public box_id: number

  @hasOne(() => Box, {
    foreignKey: 'boxId',
    localKey: 'id'
  })
  public boxes: HasOne<typeof Box>

  @column({ serializeAs: null })
  public game_id: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
