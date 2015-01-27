Cordova Gigya
================

[Cordova](http://cordova.apache.org/) plugin that handles Gigya integration for mobile (iOS and Android) apps.

Project uses mobile native Gigya SDK for iOS and Androidplat to utilize basic operations for a mobile app that uses Cordova. 

## Prerequisites

### iOS
In iOS is mandatory to use the native Facebook integration, for that we need to use the FacebookSDK.

Download the latest [FacebookSDK](https://developers.facebook.com/docs/ios/), and follow the [getting started guideline](https://developers.facebook.com/docs/ios/getting-started/). 

Copy the facebook framework to your project folder
```shell
cd my_project
cp -R ~/Documents/FacebookSDK/FacebookSDK.framework . 
# This is the default location
```

## Installing the plugin
To add this plugin just type:
```
cordova plugin add https://github.com/platanus/cordova-gigya --variable FB_APP_NAME=<facebook app name> --variable FB_APP_ID=<facebook app id>
```

## To remove this plugin type:
```
cordova plugin remove us.platan.gigya
```

##Usage

The plugin has the following methods:

* [initialize](#initialize)
* [showLoginUI](#showLoginUI)
* [logout](#logout)
* [getUserInfo](#getUserInfo)
* [getSession](#getSession)

***


### initialize
Initializes the Gigya SDK and sets your partner API key.

###### Parameters

- **api_key** (string): The Gigya Site api key

###### Example

```js
cordova.plugins.CordovaGigya.initialize(apiKey)
```

### showLoginUI
Displays a provider selection dialog, allowing the user to login to any of the supported providers.

###### Parameters

- **providers** (array): *optional* An array of providers name strings that should be displayed on the UI. The list also defines the order in which the icons will be presented. 
- **successCallback** (function): Called with user info data
- **failureCallback** (function): Called with error message

###### Example

```js
cordova.plugins.CordovaGigya.showLoginUI(
    ['twitter', 'facebook']
    function(user){
        console.log(user);
    },
    function(error){
        console.log(error)
    })
```

### logout
Logs out from Gigya and clears the saved session.

###### Parameters

- **successCallback** (function): Called after logged out
- **failureCallback** (function): *(IOS only)* Called with error message

###### Example

```js
cordova.plugins.CordovaGigya.logout(
    function(){
        console.log("logged out");
    },
    function(error){
        console.log("ios error");
        console.log(error);
    })
```

### sendRequest
Sends a request to Gigya server. This method is used for invoking any of the methods supported by [Gigya's REST API][gigya-api].

###### Parameters

- **method** (string): Name of the method to be called
- **params** (object): *optional* Optional parameters for methods that require them
- **successCallback** (function): Called with request response
- **failureCallback** (function): Called with error message

###### Example

```js
cordova.plugins.CordovaGigya.showLoginUI(
    "socialize.getSessionInfo",
    {
        provider: "twitter"
    }
    function(user){
        console.log(user);
    },
    function(error){
        console.log(error)
    })
```

[gigya-api]: http://wiki.gigya.com/030_API_reference/020_REST_API

### getSession
Retrieves the current session.

###### Parameters

- **successCallback** (function): Called with session token
- **failureCallback** (function): Called when error

###### Example

```js
cordova.plugins.CordovaGigya.showLoginUI(
    function(token){
        console.log(token);
    },
    function(){
        console.log()
    })
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/cordova-gigya/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

cordova-gigya is maintained by [platanus](http://platan.us).

## License

Apache License Version 2.0.
