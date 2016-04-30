`import Ember from 'ember'`
`import _ from 'lodash'`

AutobahnTestListComponent = Ember.Component.extend
  ajax: Ember.inject.service()

  reports: null

  getReports: Ember.on 'init', ->
    url = @get 'reportsUrl'
    ajax = @get 'ajax'
    ajax.request(url + 'index.json').then (data) =>
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

      @set 'reports', _.map(reports, (pair) -> 
        rep = pair[1]
        caseName = rep.reportfile.split('.')[0]
        rep.url = url + caseName + '.html'
        rep
      )

`export default AutobahnTestListComponent`
