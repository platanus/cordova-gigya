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

  showLoginUI: function(providers, success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "showLoginUI",
         [providers]);
  },


  getSession: function(success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "getSession",
         []);
  },


  getUserInfo: function(success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "getUserInfo",
         []);
  },


  logout: function(success, failure) {
    exec(success || function() {},
         failure || function() {},
         "CordovaGigya",
         "logout",
         []);
  }

};
