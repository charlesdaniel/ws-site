`import Ember from 'ember'`
`import config from 'ws-site/config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'guide', ->
    @route 'deflate'
    @route 'ssl'

  @route 'testing', ->
    @route 'autobahn'
    @route 'results', path: 'autobahn/results'

  @route 'examples'

  @route 'docs'
  @route 'chat'
  @route 'not-found', path: '/*page'

`export default Router`
