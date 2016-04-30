/*jshint node:true*/
/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var Funnel = require('broccoli-funnel');

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    sassOptions: {
      includePaths: [
        'bower_components/bootstrap-sass/assets/stylesheets'
      ]
    }
  });

  var extra = new Funnel('bower_components/bootstrap-sass/assets');

  app.import('bower_components/bootstrap-sass/assets/javascripts/bootstrap.js');

  return app.toTree(extra);
};
