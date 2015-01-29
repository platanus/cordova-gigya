var argscheck = require('cordova/argscheck'),
utils = require('cordova/utils'),
exec = require('cordova/exec');

module.exports = {

  initialize: function(api_key) {
    exec(null,
         null,
         "CordovaGigya",
         "initialize",
         [api_key]);
  },

  showLoginUI: function(providers, params, success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "showLoginUI",
         [providers, params]);
  },

  login: function(provider, params, success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "login",
         [provider, params]);
  },

  getSession: function(success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "getSession",
         []);
  },


  sendRequest: function(method, params, success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "sendRequest",
         [method, params]);
  },


  logout: function(success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "logout",
         []);
  }

};
