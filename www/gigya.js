var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var Gigya = function() {
};


Gigya.initialize = function(text) {
 exec(null, null, "CordovaGigya", "initialize", [text]);
};

Gigya.showLoginUI = function() {
 exec(null, null, "CordovaGigya", "showLoginUI", []);
};

module.exports = Gigya;



