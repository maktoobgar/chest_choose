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
  public boxId: number

  @hasOne(() => Box, {
    foreignKey: 'id',
    localKey: 'boxId'
  })
  public box: HasOne<typeof Box>

  @column({ serializeAs: null })
  public gameId: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
