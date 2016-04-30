`import Ember from 'ember'`
`import ENV from 'ws-site/config/environment'`

DocsRoute = Ember.Route.extend
  model: ->
    index: ENV.docs.index

`export default DocsRoute`
