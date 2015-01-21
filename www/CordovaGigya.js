var argscheck = require('cordova/argscheck'),
    utils = require('cordova/utils'),
    exec = require('cordova/exec');

var Gigya = function() {
};


Gigya.initialize = function(api_key) {
 exec(null, null, "CordovaGigya", "initialize", [api_key]);
};

Gigya.showLoginUI = function() {
 exec(success, error, "CordovaGigya", "showLoginUI", []);
};

Gigya.getSession = function() {
 exec(null, null, "CordovaGigya", "getSession", []);
};

Gigya.getUserInfo = function() {
 exec(user, null, "CordovaGigya", "getUserInfo", []);
};

Gigya.logout = function() {
 exec(null, null, "CordovaGigya", "logout", []);
};



module.exports = Gigya;


function success(user){
  console.log(JSON.parse(user));
}


function error(message){
  console.log(message);
}

function user(user){
  console.log(JSON.parse(user));
}
