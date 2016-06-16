`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend

  actions:
    willTransition: ->
      @controllerFor('application').set 'isShowingGuide', false
      @controllerFor('application').set 'isShowingTest', false
      @controllerFor('application').set 'isShowingMenu', false
      $('.navbar-collapse').css 'display', ''

    showMenu: ->
      console.log 'men men'
      con = @controllerFor 'application'
      con.toggleProperty 'isShowingMenu'
      if con.get 'isShowingMenu'
        $('.navbar-collapse').css 'display', 'block'
      else
        $('.navbar-collapse').css 'display', ''

`export default ApplicationRoute`
