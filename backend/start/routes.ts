import Route from '@ioc:Adonis/Core/Route'

Route.get('/', async () => {
  return { hello: 'world' }
})

Route.get('me/', 'UsersController.me')
  .middleware('auth')

Route.group(() => {
  Route.post('signin/', 'UsersController.signin')
  Route.post('signup/', 'UsersController.signup')
  Route.post('signout/', 'UsersController.signout')
    .middleware('auth')
})
  .prefix('auth/')

Route.group(() => {
  Route.get('', 'GamesController.retrieve')
  Route.post('', 'GamesController.create')
    .middleware('boxRandCountControl')
})
  .prefix('game/')
  .middleware('auth')

Route.group(() => {
  Route.get('', 'BoxesController.list')
  Route.get(':id/', 'BoxesController.retrieve')
    .where('id', /^[1-9][0-9]*$/)
    .middleware('getBox')
  Route.post('', 'BoxesController.create')
})
  .prefix('box/')
  .middleware('auth')
