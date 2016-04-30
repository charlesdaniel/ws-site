`import Ember from 'ember'`

ChatBarComponent = Ember.Component.extend
  ws: Ember.inject.service(),

  nextMessage: null
  isJoined: false
  nick: null
  messages: []
  didManualScroll: false
  autoScrolling: false

  actions:
    submitMessage: (msg) ->
      msg = msg.trim()
      if msg
        @get('ws').send
          path: '/message'
          content:
            nick: @get 'nick'
            message: msg

      @set 'nextMessage', null

    submitNick: ->
      if @get 'nick'
        @get('ws').send
          path: '/join'
          content:
            join_nick: @get 'nick'

    updateScroll: ->
      if !@get 'didManualScroll'
        @set 'autoScrolling', true
        elem = @$('.record-inner').get 0
        elem.scrollTop = elem.scrollHeight

  didRender: ->
    @_super(arguments...)
    @$('#chat-message-input').focus()
    @send 'updateScroll'

  didInsertElement: ->
    ws = @get('ws')
    ws.on '/message', (evt, data) =>
      @get('messages').pushObject data.content

    ws.on '/joined', (evt, data) =>
      @get('messages').pushObject data.content
      @set 'isJoined', true

    ws.on '/error', (evt, data) =>
      alert(data.content)

    @$('.record-inner').on 'scroll', =>
      if !@get 'autoScrolling'
        @set 'didManualScroll', true
      @set 'autoScrolling', false


`export default ChatBarComponent`
