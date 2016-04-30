`import Ember from 'ember'`
`import ENV from 'ws-site/config/environment'`

WS = Ember.Service.extend
  _socket: null,
  _tries: 0,

  init: ->
    @get 'socket'

  socket:
    Ember.computed ->
      if @get('_socket') == null
        sock = new WebSocket ENV.API.wsAddress
        sock.onopen = =>
          @set '_tries', 0
          $(@).trigger 'open'
        sock.onmessage = (evt) =>
          data = JSON.parse(evt.data)
          $(@).trigger data.path, data
        sock.onclose = =>
          @set '_socket', null
          Ember.run.later @, (->
            @set '_tries', @get('_tries') + 1
            @get 'socket'
          ), @get('_tries') * 500
          $(@).trigger 'close'

        $(@).on 'open', ->
          console.log 'opened ws'
        $(@).on 'close', ->
          console.log 'closed ws'

        @set '_socket', sock
      @get '_socket'
    .property '_socket'

  send: (msg) ->
    if @get('socket').readyState > 0
      @get('socket').send JSON.stringify msg
    else
      self = @
      self.on 'open', ->
        self.get('socket').send  JSON.stringify msg
        self.off 'open', @

  send_bin: (msg) ->
    if @get('socket').readyState > 0
      @get('socket').send msg
    else
      self = @
      self.on 'open', ->
        self.get('socket').send msg
        self.off 'open', @

  on: (event_name, callback) ->
    $(@).on event_name, callback

  off: (event_name, callback) ->
    $(@).off event_name, callback


`export default WS`
