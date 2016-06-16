`import Ember from 'ember'`
`import _ from 'lodash'`

TestingResultsRoute = Ember.Route.extend
  ajax: Ember.inject.service()
  fastboot: Ember.inject.service()

  model: ->
    Ember.RSVP.hash
      servers: @getReports '/reports/servers/'
      clients: @getReports '/reports/clients/'

  getReports: (path) ->
    ajax = @get 'ajax'
    if @get 'fastboot.isFastBoot'
      host = @get 'fastboot.request.host'
      protocol = @get 'fastboot.request.protocol'
      url = protocol + '://' + host + path + 'index.json'
    else
      url = path + 'index.json'

    ajax.request(url).then (data) =>
      reports = _(data['WS-RS']).pairs().value()
      reports.sort (a, b) ->
        a_version = a[0].split '.'
        b_version = b[0].split '.'

        ma = parseInt(a_version[0]) - parseInt(b_version[0])
        if ma != 0
          return ma

        mi = parseInt(a_version[1]) - parseInt(b_version[1])
        if mi != 0
          return mi

        pa = parseInt(a_version[2]) - parseInt(b_version[2])
        if pa != 0
          return pa

        0

      _.map reports, (pair) ->
        rep = pair[1]
        caseName = rep.reportfile.split('.')[0]
        rep.url = url + caseName + '.html'
        rep
    .catch (error) =>
      console.log 'got error', error

`export default TestingResultsRoute`
