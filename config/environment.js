/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'ws-site',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    contentSecurityPolicy: {
      'default-src': "10.0.0.11:3200 localhost:3200",
      'script-src': "'self' 'unsafe-inline' https://maxcdn.bootstrapcdn.com https://cdnjs.cloudflare.com",
      'font-src': "'self' http://fonts.gstatic.com", // Allow fonts to be loaded from http://fonts.gstatic.com
      'connect-src': "'self' ws://10.0.0.11:3012",
      'img-src': "'self'",
      'style-src': "'self' 'unsafe-inline' https://cdnjs.cloudflare.com",
      'media-src': "'self'"
    },

    API: {
      wsAddress: 'ws://localhost:3012',
    },

    docs: {
      index: '/api_docs/ws/index.html',
    },

    autobahn: {
      clients: '/reports/clients',
      servers: '/reports/servers',
    },

    fastboot: {
      hostWhitelist: ['ws-rs.org', '127.0.0.1:3080', /^localhost:\d+$/],
    },
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.API.wsAddress = 'wss://ws-rs.org/socket';
  }

  return ENV;
};
