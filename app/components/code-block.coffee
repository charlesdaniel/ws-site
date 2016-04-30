`import Ember from 'ember'`

CodeBlockComponent = Ember.Component.extend
  tagName: 'pre'
  codeClass: 'rust c'

  highlight: Ember.on 'didRender', ->
    @$('code').each (i, block) ->
      hljs.highlightBlock block

`export default CodeBlockComponent`
