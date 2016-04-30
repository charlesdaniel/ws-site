`import Ember from 'ember'`

NavBarComponent = Ember.Component.extend
  didInsertElement: ->
    @$('li a').click (evt) =>
      if $(evt.target).hasClass 'dropdown-toggle'
        return
      @$('.navbar-collapse').removeClass 'in'


`export default NavBarComponent`
