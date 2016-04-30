`import Ember from 'ember'`

AutobahnTestItemComponent = Ember.Component.extend
  tagName: 'span'
  behavior: Ember.computed 'report.behavior', ->
    behave = @get 'report.behavior'

    if behave == 'OK'
      'ok'
    else if behave == 'FAILED'
      'failed'
    else if behave == 'INFORMATIONAL'
      'inform'
    else if behave == 'UNIMPLEMENTED'
      'unimplemented'
    else if behave == 'NON-STRICT'
      'non-strict'


`export default AutobahnTestItemComponent`
